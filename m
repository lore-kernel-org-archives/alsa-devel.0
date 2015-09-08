From: Markus Seeber <markus.seeber@spectralbird.de>
Subject: Re: Getting notification of sound card load
Date: Tue, 8 Sep 2015 19:28:35 +0200
Message-ID: <55EF1AC3.20000@spectralbird.de>
References: <CAHS8izNFuofTe1Ud7Oa=L0RTtdT-KqnTdoO81ffMjDwH9RiyEQ@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from wp388.webpack.hosteurope.de (wp388.webpack.hosteurope.de
 [80.237.133.157])
 by alsa0.perex.cz (Postfix) with ESMTP id 24D8A2650F2
 for <alsa-devel@alsa-project.org>; Tue,  8 Sep 2015 19:33:33 +0200 (CEST)
In-Reply-To: <CAHS8izNFuofTe1Ud7Oa=L0RTtdT-KqnTdoO81ffMjDwH9RiyEQ@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On 09/08/2015 07:09 PM, Mina Almasry wrote:
> Hi,
> 
> I'd like to get a notification when a new sound card becomes available in
> my system.

You may have a look at udev, especially the monitoring interface of libudev.

I don't know if this is outdated, but maybe have a look here:
http://www.signal11.us/oss/udev/

Best Regards,
  Markus
