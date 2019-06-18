From: "scott andrew franco" <samiam@moorecad.com>
Subject: Issues with tip alsa-lib (stable, 1.1.9)
Date: Tue, 18 Jun 2019 09:14:24 -0700
Message-ID: <20190618091424.6c61c97e98fe7bb02193b2d6dca4a85a.2b4174f59f.mailapi@email03.godaddy.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from p3plwbeout03-05.prod.phx3.secureserver.net
 (p3plsmtp03-05-2.prod.phx3.secureserver.net [72.167.218.217])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by alsa1.perex.cz (Postfix) with ESMTPS id 320E8F80CC4
 for <alsa-devel@alsa-project.org>; Tue, 18 Jun 2019 18:14:56 +0200 (CEST)
List-Unsubscribe: <https://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <https://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: "Alsa-devel" <alsa-devel-bounces@alsa-project.org>
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

A roundup of my current issues with the alsa-lib repository:
 
1. No apparent .so (dynamic link) file output.
 
The configure and make instructions were followed, and no apparent .so
resulted:
 
samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$ find . -name *.so
samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$ find . -name *.a
./src/timer/.libs/libtimer.a
./src/rawmidi/.libs/librawmidi.a
./src/ucm/.libs/libucm.a
./src/topology/.libs/libtopology.a
./src/.libs/libasound.a
./src/hwdep/.libs/libhwdep.a
./src/seq/.libs/libseq.a
./src/mixer/.libs/libmixer.a
./src/control/.libs/libcontrol.a
./src/pcm/.libs/libpcm.a
samiam@samiam-home-pc:~/projects/alsa/alsa-lib-1.1.9$
 This has made it difficult to debug issues with the library.
 Using the configure flags does not seem to have an effect on this, IE:
 ./configure --enable-shared=yes --enable-static=no
 Linux distributions have libasound.so files in them, so clearly it was
 possible at some time in the past.
  
 2. Build instructions are conflicting.
 ./configure
 make
 Does work on this version. This is the standard GNU build method, and I 
 have seen these build instructions around the internet for building alsa.
 The INSTALL file recommends:
 ./gitcompile
 Which also (appears) to work, but no reason appears for why this special
 file is needed or what it does that is different. I can't get a .so (dynamic library
 from the build, so I can't check the function of the resulting build.
 Is there a reason the instructions from ./gitcompile cannot be merged back
 into the make?
  
 3. make install brings the system down.
 Executing:
 make install
 Brought my ubuntu 18.04 sound system down. I had to reinstall Ubuntu to get
 it to work again.
  
 In summary, ALSA is not a development project anymore. It is the "official sound
 system of Linux" and is part of the kernel. There is a lot of activity on the ALSA
 list. Cannot some effort be put into professionalizing the repository?
  
 Thank you for your attention,
 Scott A. Franco
 San Jose, CA
