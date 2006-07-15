From: John Pham <jvp256@yahoo.com>
Subject: alsa driver installation doc out of date (intel8x0)
Date: Fri, 14 Jul 2006 22:35:44 -0700
Message-ID: <1152941744.14912.12.camel@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
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

Hi, these docs are not up to date with the latest install scripts:

http://www.alsa-project.org/alsa-doc/doc-php/template.php?company=Intel&card=ICH+southbridge+AC97+modem.&chip=440MX%2C+i810%2C+i810E%2C+i820%2C+ICH4%2C+ICH5%2C+ICH6&module=intel8x0

In particular, as a Linux newbie, I was baffled by the following issues:

(1) alsa driver configuration parameters broken in configure script. The
HTML doc 
recommends the following command line to include the sequencer in the
build. 
In fact the option EXCLUDES the sequencer! (filed as bug 2282)

        cd alsa-driver-xxx
        ./configure --with-cards=intel8x0 --with-sequencer=yes;make;make install

(2) The snddevices script is only recommended for pre-0.9.4 drivers. But I found 
that I needed to run this script for alsa driver version 1.0.11

        NB. If you are using drivers before 0.9.4 then you need to run
 	./snddevices

(3) The INSTALL files describe very helpful utilities which are not mentioned 
in the HTML documentation. I would have found it helpful if the HTML 
documentation recommended "read the INSTALL file" for version > xxx for older 
versions you can follow this guide. (Although the introductory issues such 
as soundcore, downloading files, and also installing alsa-lib/alsa-util are still useful.)

Regards,
John Pham



-------------------------------------------------------------------------
Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
