From: Ryan Pavlik <rpav@nwlink.com>
Subject: Re: MTP/AV / Sequencer MIDI problem... design issue?
Date: Sat, 11 Jan 2003 20:37:09 -0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030111203709.20df5ff0.rpav@nwlink.com>
References: <20030111165908.386c27c4.rpav@nwlink.com>
	<200301120151.h0C1p3X8029477@spider.tela.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200301120151.h0C1p3X8029477@spider.tela.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sat, 11 Jan 2003 20:50:49 -0500
Paul Davis <paul@linuxaudiosystems.com> wrote:
> 
> i would have thought that the mtpav driver should do the same
> thing. if you want to access all 8 ports, you should have 8 access
> points (whether this is via the sequencer or the rawmidi interface),
> and write to each one of them. the use of the "Dn" byte(s?) to switch
> output ports shouldn't be exported to user space. 

It does, and you do... except the driver has the problems with parallel
access of ports I mentioned in the original message.  When you access
them with the sequencer API, the driver/library doesn't seem to properly
send entire messages.  Thus the problem arises.

-- 
Ryan Pavlik <rpav@users.sf.net>

"Nautical, schmautical. Give me one hour and I'll know
 enough to sail us into orbit!


-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com
