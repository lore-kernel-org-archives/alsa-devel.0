From: Paul Davis <pbd@op.net>
Subject: Re: Re: hdsp on big-endian
Date: Thu, 23 May 2002 10:20:38 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17AtQH-0001Pc-00@usw-sf-list1.sourceforge.net>
References: <s5h661ffana.wl@alsa2.suse.de>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 23 May 2002 11:58:49 +0200."
             <s5h661ffana.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>but still one thing is not certain.  what does the following (in
>snd_hdsp_initialize_firmware) set?
>
>	#ifdef SNDRV_BIG_ENDIAN
>		hdsp_write(hdsp, HDSP_jtagReg, HDSP_BIGENDIAN_MODE);
>	#endif
>
>does it switch the access to big-endian?  if yes, then we need
>cpu_to_xxx things there (to revert the conversion in readX/writeX), or
>use __raw_readX/writeX for access.

No, this switches *only* the byte order of audio data. The registers
are always little endian. 

--p

_______________________________________________________________

Don't miss the 2002 Sprint PCS Application Developer's Conference
August 25-28 in Las Vegas -- http://devcon.sprintpcs.com/adp/index.cfm
