From: Bernhard Gerlach <gerlacbd@emt.iis.fhg.de>
Subject: Re: sequencer buffer
Date: Thu, 13 Nov 2003 16:27:31 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3FB3A2E3.5040103@emt.iis.fhg.de>
References: <200311071308.hA7D8vq9029278@oud.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200311071308.hA7D8vq9029278@oud.linuxaudiosystems.com>
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

Hi,

late, but its comes: my answer.

Paul Davis wrote:
> you cannot send 100% valid MIDI time code on a Linux system without
> the high resolution timers patch or some other interrupt source that provides
> a suitable timing resolution.
> [..]

Ok. I didn't really think about that. I deferred generating time code, 
since it is not very important at the moment. Maybe I have to work on 
that later, but then I'll first have to look for a appropriate timing 
hardware and something like a realtime/high res timer patch for the 
linux kernel.

> i know that this isn't directly related to your question, but i wanted
> to alert you to this issue. although other devices will be able to
> chase your MTC data stream, some or even all will not lock to it
> because it is jittery/bursty.

Thanks a lot for this suggestion!

Bernhard

-- 

---------------------------------
Bernhard Gerlach
Fraunhofer AEMT
Am Helmholtzring 1 (Haus M)
98693 Ilmenau
Germany

mail: gerlacbd@emt.iis.fhg.de
---------------------------------



-------------------------------------------------------
This SF.Net email sponsored by: ApacheCon 2003,
16-19 November in Las Vegas. Learn firsthand the latest
developments in Apache, PHP, Perl, XML, Java, MySQL,
WebDAV, and more! http://www.apachecon.com/
