From: "Eduardo Valentin" <edubezval@gmail.com>
Subject: [EXT PCM / CTL Plugin][RFC][ANNOUNCE] Alsa support for
	n770
Date: Thu, 5 Oct 2006 10:26:18 -0400
Message-ID: <a0580c510610050726i3fe8437cm1e783e1b6305f3bc@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
Content-Disposition: inline
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
Sender: alsa-devel-bounces@lists.sourceforge.net
Errors-To: alsa-devel-bounces@lists.sourceforge.net
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Hello all,


    I'd like to announce an alsa plugin project to add support for
ALSA application on nokia 770. I'd like also to ask you comments and
suggestions about the code.

    Although n770 hasn't ALSA kernel driver, it is possible to write a
user-space driver to communicate with n770's audio system.

   The n770's audio system is based on DSP gateway project:
(http://dspgateway.sourceforge.net/pub/index.php)

   To add ALSA support, an EXT PCM I/O plugin and EXT CTL plugin were
written. The code is based on SDK documentation from the alsa-project
site.

    The project is in garage.maemo:
https://garage.maemo.org/projects/dsp-alsa/

     You can have a look at its REAME file in:
https://garage.maemo.org/plugins/scmsvn/viewcvs.php/alsa-plugin/debian/README?root=dsp-alsa&view=markup

    It is possible also to browse the its source code svn repository in:
https://garage.maemo.org/plugins/scmsvn/viewcvs.php/alsa-plugin/?root=dsp-alsa

-- 
Eduardo Bezerra Valentin

-------------------------------------------------------------------------
Take Surveys. Earn Cash. Influence the Future of IT
Join SourceForge.net's Techsay panel and you'll get the chance to share your
opinions on IT & business topics through brief surveys -- and earn cash
http://www.techsay.com/default.php?page=join.php&p=sourceforge&CID=DEVDEV
