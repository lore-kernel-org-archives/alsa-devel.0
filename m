From: Corey Boyle <corey.j.boyle@gmail.com>
Subject: Audo capture not working with HP 9000 laptop and
	2.6.32 kernel
Date: Sun, 11 Oct 2009 20:53:15 +0900
Message-ID: <41e5da3e0910110453w1e48da13x6c0a9ce5b17b9b2c@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from fg-out-1718.google.com (fg-out-1718.google.com [72.14.220.152])
	by alsa0.perex.cz (Postfix) with ESMTP id 2D2DF245A4
	for <alsa-devel@alsa-project.org>;
	Sun, 11 Oct 2009 13:53:17 +0200 (CEST)
Received: by fg-out-1718.google.com with SMTP id d23so459663fga.2
	for <alsa-devel@alsa-project.org>; Sun, 11 Oct 2009 04:53:16 -0700 (PDT)
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hi

I have an HP 9000 series laptop with an Intel HD sound card and Realtek
ALC298 codec.  I am having a problem with audio capture ever since upgrading
to the 2.6.32 kernel series from 2.6.31.  I have git bisected to this
commit: 33d78674586aeb6a623b1e612e6f92dd83015ed3 "ALSA: hda - Use auto model
for HP laptops with ALC268 codec".  After this commit I am not able to
capture audio and using alsamixer I am not able to choose the input source.
I was using "Front Mic" as the input source when this was working in
2.6.31.  I have uploaded my configuration using alsa-info before and after
the commit.

Before change
http://www.alsa-project.org/db/?f=4f5d3eb02d4d62fa044a4eb0a3aae2614064b208

After change
http://www.alsa-project.org/db/?f=a9583da102419a9233cc469259c85ab81645d555

Could someone please provide some help in getting this working, presumably
without rolling back the previously mentioned commit?  I am not familiar
with how the alsa code works but am willing to help out if given some
guidance.

Please CC me on all replies as I am not a subscriber to the list.

Thanks
Corey
