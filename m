From: Florian Schmidt <mista.tapas@gmx.net>
Subject: Re: aoss patch [against cvs?]
Date: Tue, 27 Jul 2004 17:45:22 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040727174522.6fb1bca0@mango.fruits.de>
References: <20040723164816.622682b5@mango.fruits.de>
	<s5hacxl5zii.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hacxl5zii.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 27 Jul 2004 15:51:49 +0200
Takashi Iwai <tiwai@suse.de> wrote:

> At Fri, 23 Jul 2004 16:48:16 +0200,
> Florian Schmidt wrote:
> > 
> > Hi
> > 
> > here's a patch that builds upon my last one.. this cleans minor
> > things up a little bit and changes the manpage.. So this is not
> > against 1.0.5, but against 1.0.5 with my other patch applied.. 
> 
> Don't we need to check /dev/dsp[0-9] and /dev/mixer[0-9]?

static int is_dsp_device(const char *pathname)
{
        if(!pathname) return 0;
        if(strncmp(pathname,"/dev/dsp",8) == 0) return 1;
        if(strncmp(pathname,"/dev/adsp",9) == 0) return 1;
        if(strncmp(pathname,"/dev/audio",10) == 0) return 1;
        if(strncmp(pathname,"/dev/sound/dsp",14) == 0) return 1;
        if(strncmp(pathname,"/dev/sound/adsp",15) == 0) return 1;
        if(strncmp(pathname,"/dev/sound/audio",16) == 0) return 1;
        return 0;
}

this should return 1 for /dev/dsp*, dev/adsp*, /dev/audio*,
/dev/sound/dsp*, dev/sound/adsp*, /dev/sound/audio*, 

and this 

static int is_mixer_device(const char *pathname)
{
        if(!pathname) return 0;
        if(strncmp(pathname,"/dev/mixer",10) == 0) return 1;
        if(strncmp(pathname,"/dev/sound/mixer",16) == 0) return 1;
        return 0;
}

should as well check /dev/mixer* and /dev/sound/*. I added the
/dev/sound/* support because i thought that devfs users might have set
their OSS apps to use the device files in /dev/sounds. The /dev/audio*
support was in the original alsa-oss.c. But it's good that you ask,
because i'm not sure, if this is "the right thing to do"..

I also wondered about the effect of specifying different dspN's [with N
element of {"", "0", .. ,"9"}]. Afaics this doesn't really have an
effect on the alsa-oss lib.. Oh i see it now.. The mapping happens in
pcm.c and mixer.c. In pcm.c lib_oss_pcm_open redoes the checks.. Hmm , i
have to meditate over this for a while. Regard my last patch as not
mailed to the mailing list :)

Florian Schmidt


-- 
Palimm Palimm!
http://affenbande.org/~tapas/



-------------------------------------------------------
This SF.Net email is sponsored by BEA Weblogic Workshop
FREE Java Enterprise J2EE developer tools!
Get your free copy of BEA WebLogic Workshop 8.1 today.
http://ads.osdn.com/?ad_id=4721&alloc_id=10040&op=click
