From: Chien Lee <Chien.Lee@mascorp.com>
Subject: Envy24-VT1712 Interrupt by Input Lines
Date: Wed, 23 Apr 2003 11:23:50 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EA6DA36.77BD0E0D@masirv.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="ISO-8859-1"
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

Hi,

I have a question regarding to how to find out which input line
(PSDIN0-PSDIN3)
is interrupting Envy24-VT1712 PCI Audio Controller.

VT1712's Professional Multi-Track Control Register MT00 provides bit 1
for
Multi-track record interrupt status. It only shows that there is an
interrupt occurred
for recording. It does not indentify which input line is the source. If
I am recording
PSDIN1audio signal and there is signal present at PSDIN0, I would get
interrupted
and record a wrong signal from PSDIN0.

Is there any way that I can find out which input line is interrupting
the chip?

Thanks,
Chien.

Disclaimer: The information contained in this transmission, including any
attachments, may contain confidential information of Matsushita Avionics
Systems Corporation.  This transmission is intended only for the use of the
addressee(s) listed above.  Unauthorized review, dissemination or other use
of the information contained in this transmission is strictly prohibited.
If you have received this transmission in error or have reason to believe
you are not authorized to receive it, please notify the sender by return
email and promptly delete the transmission.


-------------------------------------------------------
This sf.net email is sponsored by:ThinkGeek
Welcome to geek heaven.
http://thinkgeek.com/sf
