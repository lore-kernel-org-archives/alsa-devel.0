From: "Mark Knecht" <mknecht@controlnet.com>
Subject: RE: hdsp multiface pci.
Date: Wed, 22 Jan 2003 10:54:03 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <NDBBLGIKBJENLAMOLFHGAELABAAB.mknecht@controlnet.com>
References: <m3el75ghph.fsf@grouper.coelacanth.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <m3el75ghph.fsf@grouper.coelacanth.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Roger Williams <raw@qux.com>, Paul Davis <paul@linuxaudiosystems.com>
Cc: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org



> -----Original Message-----
> From: alsa-devel-admin@lists.sourceforge.net
> [mailto:alsa-devel-admin@lists.sourceforge.net]On Behalf Of Roger
> Williams
> Sent: Wednesday, January 22, 2003 10:31 AM
> To: Paul Davis
> Cc: markknecht@attbi.com; Alsa-devel@lists.sourceforge.net
> Subject: Re: [Alsa-devel] hdsp multiface pci.
>
>
> >>>>> Paul Davis <paul@linuxaudiosystems.com> writes:
>
>   >> This would explain why snd_hdsp works (i.e. you can playback and
>   >> record through the default I/O), although amixer doesn't do
>   >> anything: the driver doesn't have to set up any default
>   >> connections, because those are part of the FPGA reset state...
>
>   > actually, the driver does have to set up default connections,
>   > which are zero gain for every possible routing...
>
> Yes, I understand that that's what the driver is _supposed_ to do.
> That's how it works on my HDSP PCI and Cardbus systems.  But isn't it
> true that the current driver doesn't actually set up any of those
> zero-gain connections for the HDSP 9652?
>
> This is the only point that I was trying to make to Mark -- the
> default unity-gain connections (i.e. playback -> H/W output) that he
> has been using are FPGA configuration defaults, not explicitly set up
> by the driver.
>

Yes, and I think I understood that this was probably what was happening as
our conversation progressed. When I made that statement it was a bit earlier
on, if I remember correctly, and I was explaining my 'vision' of what I
thought was going on. That should not be confused with the trusth! ;-)

It makes perfect sense that the RME card itself has some default
connections.

Thanks,
Mark



-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
