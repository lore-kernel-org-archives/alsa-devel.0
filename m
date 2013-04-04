From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Handle large period size end-of-stream situation
Date: Thu, 04 Apr 2013 11:27:27 +0200
Message-ID: <515D477F.9010406@ladisch.de>
References: <515C459A.5070209@codeaurora.org> <515D1122.9020502@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com
 [66.111.4.25]) by alsa0.perex.cz (Postfix) with ESMTP id 0AEBA265E00
 for <alsa-devel@alsa-project.org>; Thu,  4 Apr 2013 11:27:31 +0200 (CEST)
In-Reply-To: <515D1122.9020502@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Cc: Patrick Lai <plai@codeaurora.org>, alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Gabriel M. Beddingfield wrote:
> In the typical end-of-stream case, you simply write the data that you
> have.  When the hw pointer catches up to the application pointer, you
> get an XRUN and the stream stops immediately.

But that happens only when ALSA actually reads the hardware pointer.
The application could ask for the pointer position for some reason, but
when it is blocked, only the end-of-period interrupt will cause that.


Regards,
Clemens
