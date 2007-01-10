From: "Alexander E. Patrakov" <patrakov@ums.usu.ru>
Subject: Re: Plugin for amplifying microphone (software "mic
	boost")
Date: Wed, 10 Jan 2007 15:33:12 +0500
Message-ID: <eo2f9m$b95$1@sea.gmane.org>
References: <490cd03c0701100224g11ad69a9ke3af48048504689b@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <490cd03c0701100224g11ad69a9ke3af48048504689b@mail.gmail.com>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Ilya Konstantinov wrote:
> Hi,
> 
> I'm trying to add software amplification to my Bluetooth headset (which 
> works through the ALSA userspace plugin developed by the Bluetooth-alsa 
> project). On the ALSA plugins page, I've seen two plugins which seemed 
> somehow relevant: softvol and route.
> 
> Can any of them allow me to amplify the audio (yes, I'm aware that 
> software amp. is worse), or is there some other way?

For the real microphone, +6 dB boost:

pcm.!default {
     type asym
     playback.pcm "plug:dmix"
     capture.pcm {
         type route
         slave.pcm "plug:dsnoop"
         ttable.0.0 2.0
         ttable.0.1 0.0
         ttable.1.0 0.0
         ttable.1.1 2.0
     }
}

-- 
Alexander E. Patrakov


-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
