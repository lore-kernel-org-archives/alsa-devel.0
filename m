From: Joshua Haberman <joshua@haberman.com>
Subject: poll_descriptors_count
Date: Sun, 30 Jun 2002 19:41:03 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020701024100.GG18519@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello,

int snd_pcm_poll_descriptors_count(snd_pcm_t *pcm)
{
    assert(pcm);
    return 1;
}

I don't understand: why the abstraction for the number of poll
descriptors when it is always 1?  What could change in the future to
require more poll descriptors per stream?

Also, how should programs interpret multiple poll descriptors: if the
poll succeeds on some descriptors but not others, does this mean the
stream is only "partially" ready?

Also, is snd_pcm_poll_descriptors_revents() understood to return the
events that have triggered on just *one* poll descriptor or on *all*?  In
other words, are you ANDing bitmasks or ORing them?  Right now the
semantics are impossible to deduce because the function just returns the
revents verbatim since there is only one poll descriptor.

Josh


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
