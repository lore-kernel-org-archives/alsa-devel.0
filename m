From: Gerald Grabner <gerald.grabner@gmx.net>
Subject: Re: hw_params from shared library problem
Date: Tue, 27 Jun 2006 19:08:57 +0200
Message-ID: <44A16629.4050001@gmx.net>
References: <44A04D7B.1070002@gmx.net> <44A0DAC0.5050404@purplelabs.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@lists.sourceforge.net>
In-Reply-To: <44A0DAC0.5050404@purplelabs.com>
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

Benoit Fouet wrote:

 >> Compilation:
 >>   gcc -c -fPIC object.c
 >>   gcc -shared -fPIC -o libTest.so object.o
 >>   gcc -o main main.c -L. -lTest -lasound
 >>
 >>
 > and what if you try to link your dynamic library with asound (actually,
 > this is the really needer of the link, not your test program) ? I think
 > this could help...
 >
 > gcc -shared -fPIC -o libTest.so object.o -lasound

Hey, thanks a lot, that did the trick!

Interestingly, other libraries I am using do not require to be specified 
when building the shared library.

Gerald

Using Tomcat but need to do more? Need to support web services, security?
Get stuff done quickly with pre-integrated technology to make your job easier
Download IBM WebSphere Application Server v.1.0.1 based on Apache Geronimo
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=120709&bid=263057&dat=121642
