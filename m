From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Question about dmix?
Date: Mon, 22 Mar 2010 09:03:48 +0100
Message-ID: <4BA72464.3050900@ladisch.de>
References: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out2.smtp.messagingengine.com (out2.smtp.messagingengine.com
	[66.111.4.26]) by alsa0.perex.cz (Postfix) with ESMTP id 664AB103804
	for <alsa-devel@alsa-project.org>; Mon, 22 Mar 2010 09:03:55 +0100 (CET)
In-Reply-To: <4df68b71003200705j36e71a8aicf9c44fb7f104c27@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: cee1 <fykcee1@gmail.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

cee1 wrote:
> I know alsa support userspace software multi-playback by dmix plugin.
> How does it realize? I expected a daemon accepting multi-streams which
> then mixes these streams to a single one -- it seems not the case.

The kernel maps the device's DMA buffer into all userspace processes;
the processes then cooperate in adding samples to the buffer.


Regards,
Clemens
