From: Steffen Sauder <steffensauder@gmx.de>
Subject: Re: [patch] Envy24control access to 6Fire controls
Date: Thu, 30 Oct 2003 13:36:52 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FA105E4.5020104@gmx.de>
References: <20031029232257.7fabac62.dan_a@manx.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20031029232257.7fabac62.dan_a@manx.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

>This patch against the stable version of envy24control gives access to most of the Terratec DMX 6Fire mixer controls.  It also changes the lables on the inputs in the monitor mixer to be more useful.  It should have no effect on your envy24control if you are using a card other than the 6Fire.
>
Works fine for me, nice to finally have the input switches available in 
envy24control. Though envy24control really is flexible, I always wished 
to have an less complex mixer for the DMX6Fire, but never took the time 
to write one or patch e24c for that purpuse. So if you ever get in that 
mood again, it would be nice if you could also change the other labels 
in the patchbay/router tab and the analog volume tab. (ADC0->In CD L , 
ADC1->In CD R, ..., IGPA 0 -> Gain CD-L, IPGA 1 -> Gain CD-R ...).

And I really wish I had a mixer that would handle the stereo channels as 
what they are. Its annoying to have 6 sliders for adjusting the volume 
of your line-in, for example, but since you're no programmer, you 
probably won't fix that :)

>Note that I'm not a programmer, so there might be huge errors in this...
>
Haven't really looked at the code, but it seems to work flawlessly.

gruﬂ,
Steffen



-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?   SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
