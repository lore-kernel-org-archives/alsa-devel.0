From: =?ISO-8859-1?Q?Martin_Gro=DFhauser?= <csad2635@uibk.ac.at>
Subject: arecord with RW_INTERLEAVED access
Date: Fri, 30 Jan 2004 18:55:56 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <401A9AAC.4020107@uibk.ac.at>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
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
List-Id: alsa-devel@alsa-project.org

Hello,

I already postet this on alsa-user-list, but I got no answers, perhaps
you can help me:

I'm having a problem with an app (avview) which tries to access the
soundcard (Terratec DMX 1024 --> cs46xx) via
SND_PCM_ACCESS_RW_INTERLEAVED method. It always aborts with segfault
(after reporting: snd_pcm_readi error: I/O error.)

I want to know if it's an bug of avview or of my ALSA (1.0.2 on
Gentoo with Kernel 2.4.22) config, so I try to reproduce the error with
arecord, but I'm not able to change the access method from
MMAP_INTERLEAVED to RW_INTERLEAVED.


Regards,
Martin





-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
