From: Roger Williams <raw@qux.com>
Subject: Re: hdsp multiface pci.
Date: 22 Jan 2003 13:30:50 -0500
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <m3el75ghph.fsf@grouper.coelacanth.com>
References: <200301221814.h0MIEnx0013504@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301221814.h0MIEnx0013504@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: markknecht@attbi.com, Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>>>>> Paul Davis <paul@linuxaudiosystems.com> writes:

  >> This would explain why snd_hdsp works (i.e. you can playback and
  >> record through the default I/O), although amixer doesn't do
  >> anything: the driver doesn't have to set up any default
  >> connections, because those are part of the FPGA reset state...

  > actually, the driver does have to set up default connections,
  > which are zero gain for every possible routing...

Yes, I understand that that's what the driver is _supposed_ to do.
That's how it works on my HDSP PCI and Cardbus systems.  But isn't it
true that the current driver doesn't actually set up any of those
zero-gain connections for the HDSP 9652?

This is the only point that I was trying to make to Mark -- the
default unity-gain connections (i.e. playback -> H/W output) that he
has been using are FPGA configuration defaults, not explicitly set up
by the driver.

-- 
Roger Williams <raw@qux.com>
Qux Tool & Die, Middleborough, Massachusetts
// Omne tulit punctum qui misquit utile dulci //


-------------------------------------------------------
This SF.net email is sponsored by: Scholarships for Techies!
Can't afford IT training? All 2003 ictp students receive scholarships.
Get hands-on training in Microsoft, Cisco, Sun, Linux/UNIX, and more.
www.ictp.com/training/sourceforge.asp
