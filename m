From: Mark Knecht <markknecht@attbi.com>
Subject: Re: alsaconf Problem on new CVS
Date: 06 Apr 2003 13:53:54 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1049662435.1088.5.camel@Wizard>
References: <1049647378.4200.3.camel@Wizard>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1049647378.4200.3.camel@Wizard>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@attbi.com>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Solved. Apparently /etc/asound.state has changed format somehow.
Rerunning alsamixer and then storing and retsoring the results fixed it.

Cheers,
Mark

On Sun, 2003-04-06 at 09:42, Mark Knecht wrote:
> Hi all,
>    Fernando at PlanetCCRMA has built a new (from the last few day) CVS
> version of Alsa. I've installed it via RPM, but I'm seeing the following
> problems. My suspicion is that either I have an old config file laying
> around that needs to be cleaned out, or there is a real problem here.
> 
>    The stuff at the end happens when running alsaconf, and also when
> booting.
> 
>    Can someone point me toward how I fix this? (Assuming I can...)
> 
> Thanks,
> Mark
> 
> Loading driver...
> Starting sound driver snd-via82xx                          [  OK  ]
> Starting sequencer                                         [  OK  ]
> Restoring sound driver settings /usr/sbin/alsactl: set_control:803:
> warning: name mismatch (IEC958 Capture Switch/Swap Surround Slot) for
> control #47
> /usr/sbin/alsactl: set_control:803: warning: name mismatch (Analog to
> IEC958 Output/IEC958 Capture Switch) for control #48
> /usr/sbin/alsactl: set_control:803: warning: name mismatch (IEC958 Input
> Monitor/Analog to IEC958 Output) for control #49
> /usr/sbin/alsactl: set_control:803: warning: name mismatch (External
> Amplifier Power Down/IEC958 Input Monitor) for control #50
> /usr/sbin/alsactl: set_control:803: warning: name mismatch (Input Source
> Select/External Amplifier Power Down) for control #51
> /usr/sbin/alsactl: set_control:890: bad control.51.value type
>                                                            [FAILED]
> Setting default volumes...
> ===============================================================================
> 
>  Now ALSA is ready to use.
>  For adjustment of volumes, please use alsamixer or gamix.
> 
>  Have a lot of fun!
> 
> [root@Wizard root]#
> 
> 
> 
> 
> -------------------------------------------------------
> This SF.net email is sponsored by: ValueWeb: 
> Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
> No other company gives more support or power for your dedicated server
> http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-devel




-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/
