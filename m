From: "Stephen Warren" <SWarren@nvidia.com>
Subject: Merging alsa-kernel-1.0.7 into kernel 2.6.9
Date: Thu, 18 Nov 2004 20:41:13 -0800
Message-ID: <DBFABB80F7FD3143A911F9E6CFD477B002A7F808@hqemmail02.nvidia.com>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="us-ascii"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-class: urn:content-classes:message
Sender: alsa-devel-admin@lists.sourceforge.net
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

I'm working on a project where we don't use modules for the kernel at
all - for various reasons such as target environment simplicity - very
hard-coded boot scripts, no huge sysvinit based interactive 'desktop'
system etc.

We need ALSA support, and specifically, alsa-driver 1.0.7 release fixes
some problems for the target hardware we're using.

So, I'm attempting to merge the content of alsa-driver 1.0.7 into the
kernel source tree, and to build ALSA support as non-modules.

I found a few resources that *basically* say you just copy the
alsa-kernel directory into the kernel tree and that's it. So, here's
what I started doing:

# linux-kernel.org is a virgin kernel.org 2.6.9 tree
rm -rf linux-kernel.org-2
cp -rp linux-kernel.org linux-kernel.org-2
chmod -R +w linux-kernel.org-2
rm -rf alsa-driver-1.0.7
tar jxvf patches-src/alsa-driver-1.0.7.tar.bz2
cd alsa-driver-1.0.7/alsa-kernel/
rm -rf oss
cp -a * ../../linux-kernel.org-2/sound
rm -rf ../../linux-kernel.org-2/sound/include
rm -rf ../../linux-kernel.org-2/sound/Documentation
cd include
cp -a * ../../../linux-kernel.org-2/include/sound
cd ../Documentation
cp -a * ../../../linux-kernel.org-2/Documentation/sound/alsa
cd ../../..
diff -urN linux-kernel.org linux-kernel.org-2 >
patches-src/nvidia-2.6.9-alsa-1.0.7-1.diff

This gets me a pretty fair way. I found from that point, that all I
needed to do was apply acore/init.patch, then manually fix all the calls
to module_param_array() to take a dummy count argument to back-port the
code to the 2.6.9 API.

Having done this, the kernel does compile and I can get sound working.
However, I'm wondering if this is a totally 100% correct approach. For
example, if I watch the result of a regular "./configure;make" build of
alsa-driver, I notice a lot of patches being applied to the source
before the build, most to enable the code to compile on a wide range of
kernels. If I manually apply to my tree every *.patch that the regular
build process applies, then I'm left with a few sets of errors:

* memalloc failures, due to missing header files (config.h/adriver.h if
I recall)
* KERNEL_VERSION isn't define everywhere, due to missing
<linux/version.h> includes
* still have the module_param_array problems

So, should I just ignore all the patches except init.path, do the manual
fixup of the module_param_array stuff and be done?

Any pointers on the 'correct' way to do this would be greatly
appreciated. If there's an accurate doc somewhere, my googling hasn't
found it.

Thanks.

--=20
Stephen Warren, Software Engineer, NVIDIA, Fort Collins, CO
swarren@nvidia.com        http://www.nvidia.com/
swarren@wwwdotorg.org     http://www.wwwdotorg.org/pgp.html


-------------------------------------------------------
This SF.Net email is sponsored by: InterSystems CACHE
FREE OODBMS DOWNLOAD - A multidimensional database that combines
robust object and relational technologies, making it a perfect match
for Java, C++,COM, XML, ODBC and JDBC. www.intersystems.com/match8
