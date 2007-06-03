From: acallan.alsa@ugnet.org
Subject: Re: Alsa 1.0.13 (and others) does not work on ALC880
Date: Sat, 2 Jun 2007 22:20:04 -0500 (CDT)
Message-ID: <Pine.LNX.4.58.0706022134120.29661@integrity.ugnet.org>
References: <Pine.LNX.4.58.0705190144230.8331@integrity.ugnet.org>
	<s5h7ir4etl6.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from integrity.ugnet.org (integrity.ugnet.org [208.251.149.193])
	by alsa0.perex.cz (Postfix) with ESMTP id 8D230243F5
	for <alsa-devel@alsa-project.org>;
	Sun,  3 Jun 2007 04:20:41 +0200 (CEST)
In-Reply-To: <s5h7ir4etl6.wl%tiwai@suse.de>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

I've tried to chase this problem deeper.  The chip has two codecs, 1 is
audio, 2 is modem.  In setup_fg_nodes() [hda_codec.c], the call to
snd_hda_get_sub_nodes() returns total_nodes=1 and nid=0x01 for the audio
codec.  The same call returns total_nodes=39 and nid=0x00 for the modem
codec.

Calls to azx_corb_send_cmd() [hda_intel.c] can be seen for
AC_PAR_VENDOR_ID, AC_PAR_SUBSYSTEM_ID, AC_PAR_REV_ID, AC_PAR_NODE_COUNT,
and AC_PAR_FUNCTION_TYPE for the audio codec.  32 calls to
azx_corb_send_cmd() can then be seen for AC_PAR_AUDIO_WIDGET_CAP for the
audio codec.
For the modem codec, calls to azx_corb_send_cmd() can be seen for
AC_PAR_VENDOR_ID, AC_PAR_SUBSYSTEM_ID, AC_PAR_REV_ID, and
AC_PAR_NODE_COUNT followed by 39 calls to azx_corb_send_cmd() for
AC_PAR_FUNCTION_TYPE for the modem codec.  These each return the value
AC_GRP_MODEM_FUNCTION and so the codec->mfg ends up being set to the 39th
nid (0x26).  Everything appears to be going smoothly until
read_widget_caps() is called for them modem codec.  When
snd_hda_get_sub_nodes() is called inside read_widget_caps() for fg_node
0x26, this triggers a call to azx_corb_send_cmd() for AC_PAR_NODE_COUNT.
The function azx_rirb_get_response() ends up timing out with the following
lines appearing in my dmesg log:
hda_intel: azx_get_response timeout, switching to polling mode...
hda_intel: azx_get_response timeout, switching to single_cmd mode...

>From following the code, it appears that chip->single_cmd = 1 from this
point on.  The note above the function azx_single_send_cmd() makes it
clear that this function should not be used for normal operation.  And,
indeed, after this point, calls to the chip for the audio codec seem to
return bogus values (as could be seen in the Default PCM and Node sections
of the Codec information at http://pastebin.ca/496293).

So, I have a few questions:
1)  Does it make sense that the modem codec would have 39 fg nodes?
2)  Does it make sense that the switch to single_cmd mode would possibly
be the cause of the bogus values being returned later?  (I haven't really
traced much past this point since that comment about azx_single_send_cmd
seemed to make it clear that I was already in trouble by this point.)
3)  What other things would it be helpful to look at to try to chase this
problem further?

Andrew

-- 
accallan@ugnet.org
http://www.ugnet.org/

On Sat, 19 May 2007, Takashi Iwai wrote:

> At Sat, 19 May 2007 02:08:14 -0500 (CDT),
> Andrew Callan wrote:
> >
> > I have been without sound using Fedora Core ever since the 2.6.16 or
> > 2.6.17 kernel update (2.6.16 crashed during initialization, so I could not
> > tell whether sound worked or not).  It had worked well through the 2.6.15
> > Fedora kernels.  I finally sat down tonight to work the problem as hard as
> > I could and happened upon Eric and Tobin's timely exchange.
> >
> > First, simply adding probe_mask=1 to the snd-hda-intel options worked for
> > me as well; I did not end up having to specify a specific model.
> >
> > Second, I too was seeing a LONG hang when trying to do:
> > cat /proc/asound/card0/codec#0
> > but now with the probe_mask=1, I do not see this.
> >
> > If it helps, the alsa-info.sh output for my system is at
> > http://pastebin.ca/496293
> > If it makes any difference, I'm not sure which model I had specified on
> > the modprobe line at the time I captured this output.
> >
> > One thing I do notice is that after adding probe_mask=1, aplay -l does not
> > show the Si3054 Modem which shows up in the alsa-info output.
> >
> > Thanks for the help you gave in the thread with Eric.
> >
> > Andrew
>
> Interesting.  I've seen similar reports that probe_mask helps.
> Do you disable the modem codec on BIOS or is it enabled?
>
> If this happens even though it's enabled on BIOS, we'd need a
> blacklist of non-working devices, or a more robust probing routine...
>
>
> Takashi
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
>
