From: Joshua Haberman <joshua@haberman.com>
Subject: Re: snd_pcm_start fails
Date: Thu, 4 Jul 2002 15:27:21 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20020704222721.GB23530@reverberate.org>
References: <20020704220631.GA23530@reverberate.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <20020704220631.GA23530@reverberate.org>
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

* To alsa-devel@lists.sourceforge.net (joshua@haberman.com) wrote:
> I am stumped.  This short and simple program fails for me:

Wingo solved the mystery for me.  Apparently you are required to do an
mmap_begin and mmap_commit before you can call snd_pcm_start.

Josh


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Caffeinated soap. No kidding.
http://thinkgeek.com/sf
