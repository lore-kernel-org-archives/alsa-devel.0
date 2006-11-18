From: "Giovanni Maruzzelli" <gmaruzz.lists@gmail.com>
Subject: too much latency with default:0,
	problem with period_time on dmix-dsnoop
Date: Sat, 18 Nov 2006 21:26:18 +0100
Message-ID: <7c5010d60611181226x65d6bf54q7cd4d394bbe67134@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: Alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hi all,

I have a problem of too much latency using from C the "default:n"
devices under ALSA (if I understood correctly, this is because the
"default:n" devices uses dmix and dsnoop, and I need dmix and dsnoop,
but dmix and dsnoop have a fixed period_time=125000).

I was able to solve this problem with an asound.conf, specifying the
period_time in both the dmix and dsnoop that constitute the asym that
I made the default.

There is a way to do the same from the command line, in a way similar to:
aplay -D"plug:'dmix:RATE=44100'"

Also (and maybe better), there is a way to "build" a device similar to
the one builded by this asound.conf from the C api?

Any help very much appreciated ;)
Giovanni

My sample asound.conf:

pcm.dmixed {
        ipc_key 1025
        type dmix
        slave {
                pcm "hw:0"
                period_time 20000
        }

}

pcm.dsnooped {
        ipc_key 1027
        type dsnoop
        slave {
                pcm "hw:0"
                period_time 20000
        }
}

pcm.asymed {
        type asym
        playback.pcm "dmixed"
        capture.pcm "dsnooped"
}

pcm.!default {
        type plug
        slave.pcm "asymed"
}

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys - and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
