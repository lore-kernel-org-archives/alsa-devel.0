From: "Leonidas ." <leonidas137@gmail.com>
Subject: Getting wrong offset and size value alsa library
Date: Wed, 26 Mar 2008 15:26:19 -0700
Message-ID: <f22d86810803261526p536f8937o8022257b822685e6@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from an-out-0708.google.com (an-out-0708.google.com [209.85.132.245])
	by alsa0.perex.cz (Postfix) with ESMTP id 48DB3243C0
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 23:26:21 +0100 (CET)
Received: by an-out-0708.google.com with SMTP id c36so45284ana.80
	for <alsa-devel@alsa-project.org>; Wed, 26 Mar 2008 15:26:20 -0700 (PDT)
Content-Disposition: inline
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

Hi,

I am trying to make my user space audio driver work, in my drivers transfer
function, I get wrong values of
offset and size and because of this the alsa buffer is not accessible to me
and I get a segfault in transfer.

The offset should range from 0 to n-1 where n is the buffer size, is this
correct? I can transfer the first chunk
of data and first time the offset as well as size are correct, but when the
transfer function is called again for
second period, offset values and size values are wrong, they are some
astronomical numbers.

-leo
