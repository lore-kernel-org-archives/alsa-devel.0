From: Maarten de Boer <mdeboer@iua.upf.es>
Subject: alsa 1.0.0 API changes???
Date: Tue, 9 Dec 2003 18:18:46 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20031209181846.73717fdc.mdeboer@iua.upf.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
Cc: linux-audio-dev@music.columbia.edu
List-Id: alsa-devel@alsa-project.org

Hello,

I have been unsubscribed from alsa-devel for a while, so maybe i missed
the discussion about this, but a quick look at the archives did not reveal
anything.

I just downloaded alsa 1.0.0rc2, and discovered that the API changed.
For example (and this is only an example), take the function
snd_pcm_hw_params_set_rate_near. Before, the 3th argument was the
samplerate requested, and the return value was the error value (<0) or
the samplerate obtained.

err = snd_pcm_hw_params_set_rate_near(handle, params, rate, 0);

Now, the third argument is a _pointer_, used to pass the requested value
_and_ to return the obtained samplerate. Note that the symbol is
identical, and that an application compiled against the old version will
happily link against the new version (but surely fail when executing!)
(or am I missing something here??)

I clearly see the advantage of the new, cleaner, approach, but I still
remember the past ALSA API changes, and I was under the impression that
that would not happen again. I also thought that the 0.9.x releases were
a straight line to work towards the 1.0 release. So I am very surprised
to see this happen. If this has been discussed / announced somewhere,
than I am sorry for having missed it, but in any case, I think it might
be good to place a notice on the alsa web page.

Maarten


-------------------------------------------------------
This SF.net email is sponsored by: SF.net Giveback Program.
Does SourceForge.net help you be more productive?  Does it
help you create better code?  SHARE THE LOVE, and help us help
YOU!  Click Here: http://sourceforge.net/donate/
