From: Andrei Boros <andrei@srr.ro>
Subject: alsa-lib cvs compilation attempt:
Date: Mon, 10 Mar 2003 13:24:44 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3E6C75FC.47BE6A73@srr.ro>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
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
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


 A cvs tree from 5 min. ago in alsa-lib:

loads of warnings for pcm_linear.c 

Here are only some of them. I know these aren't critical, but there are
so many of them...


gcc -DHAVE_CONFIG_H -I. -I. -I../../include -I../../include -O2 -Wall -W
-pipe -g -Wp,-MD,.deps/pcm_linear.pp -c  -fPIC -DPIC pcm_linear.c -o
pcm_linear.lo
pcm_linear.c: In function `snd_pcm_linear_convert':
pcm_linear.c:171: warning: `src' might be used uninitialized in this
function
pcm_linear.c:172: warning: `dst' might be used uninitialized in this
function
pcm_linear.c:173: warning: `src_step' might be used uninitialized in
this function
pcm_linear.c:173: warning: `dst_step' might be used uninitialized in
this function
pcm_linear.c:174: warning: `frames1' might be used uninitialized in this
function
pcm_linear.c: In function `snd_pcm_linear_getput':
pcm_linear.c:207: warning: `src' might be used uninitialized in this
function
pcm_linear.c:208: warning: `dst' might be used uninitialized in this
function
pcm_linear.c:209: warning: `src_step' might be used uninitialized in
this function
pcm_linear.c:209: warning: `dst_step' might be used uninitialized in
this function
pcm_linear.c:210: warning: `frames1' might be used uninitialized in this
function



-- 
ing. Andrei Boros
mailto:andrei@srr.ro / +40-21-303-1870
Centrul pt. Tehnologia Informatiei
Societatea Romana de Radiodifuziune


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
