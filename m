From: Carsten Koch <Carsten.Koch@icem.com>
Subject: Re: optical SPDIF output on Abit NF7 nforce2 main board.
Date: Mon, 01 Sep 2003 23:00:59 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F53B38B.6070307@icem.com>
References: <3F532D5E.6040300@icem.com>	<s5hy8x8oefw.wl@alsa2.suse.de>	<3F534D6A.5030706@icem.com>	<s5hllt8oaye.wl@alsa2.suse.de>	<3F535A42.6020403@icem.com>	<s5hekz0o7wi.wl@alsa2.suse.de>	<3F536C97.5080008@icem.com>	<s5hbru4o444.wl@alsa2.suse.de>	<3F538893.1010801@icem.com> <s5h7k4snyhl.wl@alsa2.suse.de> <3F539A3E.3030508@icem.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <3F539A3E.3030508@icem.com>
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

Hi,

here is a summary of the facts that I found so far regarding
the optical SPDIF output on my Abit NF7 nforce2 main board:

                                                        Alsa   Nvidia
                                                        driver driver
Default setting plays sound on analog output           Yes    Yes
Default setting plays sound on digital output          No     Yes
Sound works on both (D and A) outputs at the same time No     Yes
kde desktop sounds work on digital output              No     Yes
mpg123 works on digital output                         No     Yes(1)
mpg321 works on digital output                         Yes(2) Yes(3)
main volume slider controls volume on digital output   No     Yes
PCM volume slider controls volume on digital output    No     Yes
Digital output can be muted by mixer application       No     Yes

(1) Requires -r 48000 parameter unless file contains 48 kHz data.
(2) Requires -o alsa09  --audiodevice hw:0,1 parameters or
     an entry in ~/.asoundrc that makes device 1 the default.
     Sound is played at wrong speed unless data is 48kHz.
(3) Only if file contains 48 kHz data.


Carsten.



-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
