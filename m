From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: error code 130: io_open - ALSA open error
Date: Thu, 17 Jun 2010 17:09:12 +0200
Message-ID: <4C1A3A98.7050808@ladisch.de>
References: <mailman.1.1276768801.25333.alsa-devel@alsa-project.org>
	<706067.39604.qm@web65605.mail.ac4.yahoo.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 9B1E62447A
	for <alsa-devel@alsa-project.org>;
	Thu, 17 Jun 2010 17:09:31 +0200 (CEST)
In-Reply-To: <706067.39604.qm@web65605.mail.ac4.yahoo.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: "S. Aguinaga" <sa_jr@yahoo.com>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

S. Aguinaga wrote:
> I tried finding what this error code means, but my searches come up empty.

"io_open" is not an ALSA function, and ALSA uses negative error codes
(and -130 would mean "Owner died", which is not an error that ALSA
checks for).  This error code is specific to the software that you're
using.


Regards,
Clemens
