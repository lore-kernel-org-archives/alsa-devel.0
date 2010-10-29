From: chenjingy@sohu.com
Subject: which is better when porting alsa?
Date: Fri, 29 Oct 2010 07:55:23 GMT
Message-ID: <1288338923.d972f0220a6c4bb986ea66d7ccae19f1.chenjingy@sohu.com>
References: <AANLkTinTsGB4WB16xfkrvjueMGhQtTWPBbUNAuYVbZVv@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from relay.mail.sohu.com (websmtp.sohu.com [61.135.132.204])
	by alsa0.perex.cz (Postfix) with ESMTP id 258B310381C
	for <alsa-devel@alsa-project.org>;
	Fri, 29 Oct 2010 09:55:39 +0200 (CEST)
Received: from mx49.mail.sohu.com (unknown [192.168.95.243])
	by relay.mail.sohu.com (Postfix) with ESMTP id 89888F28B2B
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 15:56:29 +0800 (CST)
Received: from mx49.mail.sohu.com (tc_15_70 [127.0.0.1])
	by mx49.mail.sohu.com (Postfix) with ESMTP id 0F16920601
	for <alsa-devel@alsa-project.org>; Fri, 29 Oct 2010 15:55:23 +0800 (CST)
In-Reply-To: <AANLkTinTsGB4WB16xfkrvjueMGhQtTWPBbUNAuYVbZVv@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ALSA Development Mailing List <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dear ALSA developers,
&nbsp;&nbsp;I'm trying to port ALSA to MIPS/Linux because I want my platform more compatible to the 3rd party's software which is beased on ALSA lib.
&nbsp;&nbsp;Now I have 2 choices,
&nbsp; 1. The board's SDK already have a complete&nbsp;interface of sound on user space, so I only need port alsa library beased on current SDK's interface.
&nbsp; 2. porting both alsa library and alsa driver, and make current SDK's sound interface works in kernal space.
&nbsp;
&nbsp; If it's very easy to make current SDK's sound interface works in kernal space, which choice is better and which need less time to complete to a new alsa developer?
&nbsp;
&nbsp; I'm waiting for your reply.
&nbsp; Best regards,
Chen Jingyu
