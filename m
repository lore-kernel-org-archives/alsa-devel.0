From: Paul Davis <pbd@op.net>
Subject: Re: snd_pcm_start fails
Date: Fri, 05 Jul 2002 11:49:07 -0400
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <E17QVIE-0002rU-00@usw-sf-list1.sourceforge.net>
References: <20020704222721.GB23530@reverberate.org>
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: Your message of "Thu, 04 Jul 2002 15:27:21 PDT."
             <20020704222721.GB23530@reverberate.org>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Joshua Haberman <joshua@haberman.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

>* To alsa-devel@lists.sourceforge.net (joshua@haberman.com) wrote:
>> I am stumped.  This short and simple program fails for me:
>
>Wingo solved the mystery for me.  Apparently you are required to do an
>mmap_begin and mmap_commit before you can call snd_pcm_start.

or more generally: you have to put some data in place (somehow) before
calling start, unless you used the "start on data ready" flag during
setup. 

--p


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Bringing you mounds of caffeinated joy.
http://thinkgeek.com/sf
