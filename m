From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: hdsp update
Date: Mon, 24 Nov 2003 18:48:04 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FC24454.8000902@undata.org>
References: <3FC0EC7D.1010701@undata.org>	<s5hu14u2dwg.wl@alsa2.suse.de> <s5hhe0t3jl7.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hhe0t3jl7.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi Iwai a wrote :
> At Mon, 24 Nov 2003 12:40:15 +0100,
> I wrote:
> 
>>>A new version of hdspmixer is also available here :
>>>http://www.undata.org/~thomas/
>>>It is mostly a bugfix release for H9632 users.
>>>There is also a new version of hdspconf, but it only adds a .desktop
>>>file and a nice icon (to bring it to par with the new hdspmixer), so
>>>Takashi, feel free not to commit this one if you don't have much time :)
>>
>>i'll check this, too.
> 
> 
> ok, now they are on cvs.
> i modified the configure to add --with-desktop-dir and
> --with-pixmap-dir options, so that they can be specified separately.
> also, the --with-soundbase option works properly now.
> 
> there were several compile warnings in hdspmixer, namely, non-used
> static variables defined in some header files for label, etc.
> i added ifdef for each of them to shut up the warnings.
> 
> still there is a warning which must be fixed.
> HDSPMixerCard::getAutosyncSpeed() returns no value if external_rate =
> 6.  i assume it's 0 since the minus value will result in the error at
> starting.  please let me know the correct value it should be.
> 
> 
> Takashi

I updated hdspmixer and hdspconf to fix all these problems :
http://www.undata.org/~thomas/
I just checked cvs to send you a clean patch instead, but the latest 
changes were not in there yet. Sorry for the extra workload this gives you.

Thanks,
Thomas



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
