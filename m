From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: [PATCH] emu10k1: change "Music" to "Synth" in
	mixer control names.
Date: Tue, 28 Dec 2004 21:07:44 -0500
Message-ID: <1104286064.27377.15.camel@krustophenia.net>
References: <1104283454.27377.3.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1104283454.27377.3.camel@krustophenia.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

On Tue, 2004-12-28 at 20:24 -0500, Lee Revell wrote:
>  	snd_emu10k1_init_stereo_control(&controls[nctl++], "Wave Playback Volume", gpr, 100);
>  	gpr += 2;

I have noticed that many of the PCM controls are assigned names like
"Wave Playback Volume", and later renamed to "PCM Playback Volume" in
the devinit routine.

    476         static char *emu10k1_rename_ctls[] = {
    477                 "Surround Digital Playback Volume", "Surround Playback Volume",
    478                 "Center Digital Playback Volume", "Center Playback Volume",
    479                 "LFE Digital Playback Volume", "LFE Playback Volume",
    480                 NULL    
    481         };

    503         static char *audigy_rename_ctls[] = {
    504                 /* use conventional names */
    505                 "Wave Playback Volume", "PCM Playback Volume",
    506                 /* "Wave Capture Volume", "PCM Capture Volume", */
    507                 "Wave Master Playback Volume", "Master Playback Volume",
    508                 "AMic Playback Volume", "Mic Playback Volume",
    509                 NULL
    510         };

    560         if (emu->audigy)
    561                 c = audigy_rename_ctls; 
    562         else    
    563                 c = emu10k1_rename_ctls;
    564         for (; *c; c += 2)
    565                 rename_ctl(card, c[0], c[1]);


Maybe I am missing something but why not just call it "PCM Playback
Volume" in the first place, and clean up the code a bit?

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now. 
http://productguide.itmanagersjournal.com/
