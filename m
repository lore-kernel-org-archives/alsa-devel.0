From: Patrice Tisserand <Patrice.Tisserand@ircam.fr>
Subject: Re: HDSP MIDI question...
Date: 07 Aug 2003 09:37:37 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060241857.3137.49.camel@localhost.localdomain>
References: <20030807043553.GA8421@dogsolitude.org>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030807043553.GA8421@dogsolitude.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: drclaw@dogsolitude.org
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 2003-08-07 at 06:35, drclaw@dogsolitude.org wrote:
> Hi, when I run "aconnect -i" it just spits out "Timer" and "Announce", I
> was wondering how I'm supposed to connect my HDSP (multiface, alsa
> 0.9.6) midi input to an application.  I know it's functioning because
> jmax is able to "see" (and use) the HDSP midi ports, but aconnect can't.
> I was wondering if this was a known difficulty, or if it sounds like I'm
> doing something wrong. 
Hi,
jMax use ALSA RawMidi and Sequencer, so perhaps what you see in jMax is
only our HDSP Rawmidi ports.

I'm not sure but it seems that is the job of snd-seq-midi module.
Could you check if this module is loaded ?

Hope this help.
Bye
-- 
Patrice Tisserand <Patrice.Tisserand@ircam.fr>



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01
