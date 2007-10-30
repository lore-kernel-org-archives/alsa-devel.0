From: "Clemens Ladisch" <cladisch@fastmail.net>
Subject: Re: External Sound Card
Date: Tue, 30 Oct 2007 18:19:51 +0100
Message-ID: <1193764791.29333.1218639071@webmail.messagingengine.com>
References: <cbe89d5f922a06b0d445d95e900f3b22@optonline.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1.smtp.messagingengine.com (out1.smtp.messagingengine.com
	[66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 302E62433A
	for <alsa-devel@alsa-project.org>; Tue, 30 Oct 2007 18:19:53 +0100 (CET)
Content-Disposition: inline
In-Reply-To: <cbe89d5f922a06b0d445d95e900f3b22@optonline.net>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: John Dey <jsdey@optonline.net>, Alsa Dev <alsa-devel@alsa-project.org>, Planet ccrma <planetccrma@ccrma.stanford.edu>
List-Id: alsa-devel@alsa-project.org

John Dey wrote:
> I am looking for a external sound card that has spdif (7.1) 
> functioning.

7.1 encoding is done in software, not in hardware.
I don't know of any 7.1 encoder for Linux.

ALSA has the a52 plugin that can do 5.1 encoding for any sound
card that has SPDIF, but you'd have to compile it with the ffmpeg
library to get it to work.


HTH
Clemens
