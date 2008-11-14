From: Wu Fengguang <wfg@linux.intel.com>
Subject: Re: [RFC][PATCH] ELD routines and proc interface
Date: Fri, 14 Nov 2008 09:34:32 +0800
Message-ID: <1226626476.943818.9357@de>
References: <1226542918.126598.6912@de> <s5h4p2crsqv.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from orsmga101.jf.intel.com (mga06.intel.com [134.134.136.21])
	by alsa0.perex.cz (Postfix) with ESMTP id 7A779244A9
	for <alsa-devel@alsa-project.org>; Fri, 14 Nov 2008 02:34:40 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <s5h4p2crsqv.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 13, 2008 at 08:26:48AM +0100, Takashi Iwai wrote:
> At Thu, 13 Nov 2008 10:21:53 +0800,
> Wu Fengguang wrote:
> > 
> > Create hda_eld.c for ELD routines and proc interface.
> 
> Thanks for the patch!

I take it as my responsibility :)

> > ELD handling routines can be shared by all HDMI codecs,
> > and they are large enough to make a standalone source file.
> > 
> > Some notes on the code:
> > 
> > - Shall we show an empty file if the ELD content is not valid?
> >   Well it's not that simple. There could be partially populated ELD,
> >   and there may be malformed ELD provided by buggy drivers/monitors.
> >   So I tend to expose ELD as it is. 
> 
> Fair enough.
> 
> > - hdmi_show_eld() and hdmi_print_eld_info() are somehow duplicated
> >   The plan is to shrink hdmi_show_eld()/hdmi_show_short_audio_desc(), and to
> >   show a compact message at monitor hotplug and driver initialization time.
> 
> You can create a common print function to accept the callback, such
> as,
> 
> static void hdmi_print(void (*print)(void *, const char *line), void *data,
> 			   const char *fmt, ...)
> {
> 	char line[80];
> 	va_list ap;
> 	va_start(fp, fmt);
> 	vsnprintf(line, sizeof(line), fmt, ap);
> 	va_end(ap);
> 	print(data, line);
> }
> 
> static void hdmi_print_eld(void (*print)(void *, const char *), void *data,
> 				struct sink_eld *e)
> {
> 	hdmi_print(print, data, "monitor name\t\t%s\n", e->monitor_name);
> 	...
> }
> 				
> static void print_proc(void *data, const char *line)
> {
> 	snd_iprintf(data, "%s", line);
> }
> 
> static void hdmi_print_eld_info(struct snd_info_entry *entry,
> 				struct snd_info_buffer *buffer)
> {
> 	hdmi_print_eld(print_proc, buffer, entry->private_data);
> }
> 
> static void print_console(void *data, const char *line)
> {
> 	printk(KERN_DEBUG "%s", line);
> }
> 
> void snd_hdmi_show_eld(struct sink_eld *e)
> {
> 	hdmi_print_eld(print_console, NULL, e);
> }
> 
> Just an idea, though.
 
Wow, it would be really nice trick for a big project!
But in this case, it seems to create more code than it can reduce...

Anyway my point is that, there seems to pointless to show full
detailed ELD info in dmesg.

> > - The ELD retrieval routines rely on the Intel HDA interface,
> >   others are/could be universal and independent ones.
> > 
> > - The ELD proc interface code could be moved to hda_proc.c if necessary.
> 
> > - How do we name the proc file?
> >   If there are going to be two HDMI pins per codec, then the current naming
> >   scheme (eld#<codec no>) will fail.
> 
> In theory, yes, but I don't think this would happen.
> If this is needed, the currently existing codec#* proc must be fixed,
> too.  So, we can use eld#codec as the simplest way.

I mean one HDMI codec equipped with two output converters and two HDMI pins.
In this case there could be two HDMI sinks mapped to one single codec.

Or it would be trivial to do the rename in the future anyway?

> Some review comments below:
> 
> > --- sound-2.6.orig/sound/pci/hda/patch_intelhdmi.c
> > +++ sound-2.6/sound/pci/hda/patch_intelhdmi.c
> ...
> > @@ -880,6 +410,11 @@ static int intel_hdmi_build_controls(str
> >  
> >  static int intel_hdmi_init(struct hda_codec *codec)
> >  {
> > +	struct intel_hdmi_spec *spec = codec->spec;
> > +	struct sink_eld *eld = &spec->sink;
> > +
> > +	snd_hda_eld_proc_new(codec, eld);
> 
> The proc creation should be rather in patch_intelhdmi().
> The init callback is called also at suspend/resume usually.

OK, fixed.

> >  	/* disable audio output as early as possible */
> >  	hdmi_disable_output(codec);
> >  
> > @@ -927,3 +462,4 @@ struct hda_codec_preset snd_hda_preset_i
> >  	{ .id = 0x10951392, .name = "SiI1392 HDMI",     .patch = patch_intel_hdmi },
> >  	{} /* terminator */
> >  };
> > +
> 
> Useless space addition.

Fixed, wondering how it slipped in.

> 
> > --- /dev/null
> > +++ sound-2.6/sound/pci/hda/hda_eld.c
> > +static inline unsigned char grab_bits(const unsigned char *buf,
> > +						int byte, int lowbit, int bits)
> > +{
> > +	BUG_ON(lowbit > 7);
> > +	BUG_ON(bits > 8);
> > +	BUG_ON(bits <= 0);
> 
> Can it be rather BUILD_BUG_ON(), BTW?
> Or, hmm, doesn't work if it's an inline function?

Yes, converted to BUILD_BUG_ON() and it compiles OK.

> > +int hdmi_get_eld_size(struct hda_codec *codec, hda_nid_t nid)
> 
> I prefer snd_ prefix for global functions to avoid any potential name
> crashes.

OK.

> > +int hdmi_get_eld(struct sink_eld *eld,
> > +		 struct hda_codec *codec, hda_nid_t nid)
> 
> Ditto.
> 
> > +void hdmi_show_eld(struct sink_eld *e)
> 
> Ditto.

Three renames done.

> > --- sound-2.6.orig/sound/pci/hda/Makefile
> > +++ sound-2.6/sound/pci/hda/Makefile
> > @@ -4,6 +4,7 @@ snd-hda-intel-y := hda_intel.o
> >  # designed to be individual modules
> >  snd-hda-intel-y += hda_codec.o
> >  snd-hda-intel-$(CONFIG_PROC_FS) += hda_proc.o
> > +snd-hda-intel-$(CONFIG_SND_HDA_ELD) += hda_eld.o
> >  snd-hda-intel-$(CONFIG_SND_HDA_HWDEP) += hda_hwdep.o
> >  snd-hda-intel-$(CONFIG_SND_HDA_INPUT_BEEP) += hda_beep.o
> >  snd-hda-intel-$(CONFIG_SND_HDA_GENERIC) += hda_generic.o
> > --- sound-2.6.orig/sound/pci/hda/hda_local.h
> > +++ sound-2.6/sound/pci/hda/hda_local.h
> > @@ -276,15 +276,6 @@ static inline int snd_hda_parse_generic_
> >  #endif
> >  
> >  /*
> > - * generic proc interface
> > - */
> > -#ifdef CONFIG_PROC_FS
> > -int snd_hda_codec_proc_new(struct hda_codec *codec);
> > -#else
> > -static inline int snd_hda_codec_proc_new(struct hda_codec *codec) { return 0; }
> > -#endif
> ...
> > +/*
> > + * generic proc interface
> > + */
> > +#ifdef CONFIG_PROC_FS
> > +int snd_hda_codec_proc_new(struct hda_codec *codec);
> > +int snd_hda_eld_proc_new(struct hda_codec *codec, struct sink_eld *eld);
> 
> I'd put these two declarations rather separately, since
> snd_hda_proc_new() has nothing to do with ELD.  Keep it in the
> original place.

OK.

Thank you,
Fengguang
