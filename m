From: =?ISO-8859-1?B?uvrP/sfa?= <hu_xiaoqin@163.com>
Subject: sync problem
Date: Thu, 02 Jan 2003 13:49:42 +0800
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20030102054326.EEA9F1CB59279@sm181.163.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
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

hi,
   I developped a application which requested some real time functions. For=
=20example, it requests that a capture and write to disk occurs per 20ms. I=
=20set capture device's hardware parameters as: buffer time: 80ms, period ti=
me: 20ms, periods: 4, channles 1, rate 8000, access mode: RW_INTERLEAVED, an=
d format S16 little endien. I think, the snd_pcm_readi() will return per 20m=
s, however, the function return two times per 40ms and the first return occu=
rs after 39,xxx us and the second return occurs xxx us followed the first re=
turn. I use "gettimeofday()" function to test my application and aplay(alsa=
=20example) and get the same result. 
  Thanks.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
