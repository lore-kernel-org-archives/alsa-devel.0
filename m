From: Kai Vehmanen <kai.vehmanen@wakkanet.fi>
Subject: Re: [Alsa-user] repost: audioio-alsa error
Date: Tue, 30 Sep 2003 21:59:11 +0300 (EEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.44.0309302108300.853-100000@ecabase.localdomain>
References: <KFEKKEMAEHMNNJCLELLCGEIKCHAA.jlutch@altairinc.com>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <KFEKKEMAEHMNNJCLELLCGEIKCHAA.jlutch@altairinc.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Jamie Lutch <jlutch@altairinc.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Note: this probably belongs to alsa-devel, so please remove alsa-user from
replies.

On Fri, 26 Sep 2003, Jamie Lutch wrote:

> Didnt have any responses on my post of a few days ago, so I'm giving it
> another go:

Sorry for the late reply.

> So I have my setup (pdaudiocf card>ecasound) running fine at 24/96, but
> every once in awhile it just stops mid-stream and gives the following error:
[...]
> (audioio-alsa) Unknown Device State!

Ecasound is getting an error (res<0) from snd_read{in}/write{in}. It's one 
of...: EPIPE, EIO or EINTR.

In response, Ecasound calls snd_pcm_status() and then 
snd_pcm_status_get_state() to query, but the returned state is not 
the expected 'SND_PCM_STATE_XRUN'. I'm not sure how this could happen. I 
could not reproduce this error with the latest ALSA&ecasound on my 
soundcards.

I've added some debug printfs to the code, so could you retry the tests
with the latest Ecasound from CVS? By doing this we should at least 
learn what is the exact state the soundcard is in.

-- 
 http://www.eca.cx
 Audio software for Linux!



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
