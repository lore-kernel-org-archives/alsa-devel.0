From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: pcm_jack multi-channel and configurability patch
Date: Mon, 17 Feb 2003 16:53:12 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030217165312.7464ccdd.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: perex@suse.cz
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello Jaroslav,

Attach you find another pcm_jack patch, that contains some major
changes.

- now multichannel works (before only 1 channel worked). i tested stereo,
  and it works fine.

- i extended the configuration. the jack ports to connect to are now not
hard-coded anymore. instead, they will have to be specified in the
asound.conf, which allows to connect to any other jack client.

my asound.conf now looks like this:

pcm.jackplug {
	type plug
	slave { pcm "jack" }
}

pcm.jack {
	type jack
	playback_ports {
		0 alsa_pcm:playback_1
		1 alsa_pcm:playback_2
	}
	capture_ports {
		0 alsa_pcm:capture_1
		1 alsa_pcm:capture_2
	}
}

Is this syntax okay with you?

Right now, draining is not implemented, and I am not sure how to do it.
For you it is probably very easy. Could you have a look at it?

When I ctrl-c the alsa application (I'm testing with aplay), I notice
that close is called twice (?!), and that the client doesn't quit...
I have no idea where this problem comes from. Alsa? Jack? Maybe Paul
has an idea?

Maarten


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
