From: Andy Wingo <wingo@pobox.com>
Subject: Alsa module configuration
Date: Fri, 30 Aug 2002 00:26:48 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020830002648.H1816@cebreiro.nc.rr.com>
References: <3D6EE68D.44C094B8@localnet.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <3D6EE68D.44C094B8@localnet.com>
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

Hey alsa kernel wizards,

Is there any way we can get rid of this?

On Thu, 29 Aug 2002, frank pirrone wrote to linux-audio-user:

> *** grab the Alsa 0.9.0rc3 tarball and compile it
> *** Configure /etc/modules.conf as follows:
> 
> # ALSA native device support
> alias char-major-116 snd
> options snd snd_major=116 snd_cards_limit=1
> alias snd-card-0 snd-cs4236
> options snd-cs4236 snd_id="Crystal Audio" snd_index=0 snd_isapnp=1
> # OSS/Free compatibility setup
> alias char-major-14 soundcore
> alias sound-service-0-0 snd-mixer-oss
> alias sound-service-0-1 snd-seq-oss
> alias sound-service-0-3 snd-pcm-oss
> alias sound-service-0-8 snd-seq-oss
> alias sound-service-0-12 snd-pcm-oss
> alias sound-slot-0 snd-card-0

It just struck me how every alsa install has to do this. I am not a
kernel wiz, but it would be so much nicer if (somehow) this just worked:

alias snd-card-0 snd-cs4236

And maybe an options line with the snd_id or something. But it seems
that these are the only crucial pieces of information. I know, I know,
alsaconf is supposed to help. Still. Is there any way this can be
simpler?

Just wondering, yo.

wingo.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
