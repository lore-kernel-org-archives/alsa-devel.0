From: "Patrick Shirkey" <pshirkey@boosthardware.com>
Subject: Re: Application development
Date: Tue, 29 Apr 2014 19:07:51 +1000 (EST)
Message-ID: <59564.86.107.254.57.1398762471.squirrel@boosthardware.com>
References: <535F5775.7080504@amsat.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from boosthardware.localdomain (boosthardware.com [88.198.122.139])
 by alsa0.perex.cz (Postfix) with ESMTP id 50A1B262600
 for <alsa-devel@alsa-project.org>; Tue, 29 Apr 2014 11:06:46 +0200 (CEST)
In-Reply-To: <535F5775.7080504@amsat.org>
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


On Tue, April 29, 2014 5:40 pm, Rob Janssen wrote:
> A week and a half ago I asked some questions about application development
> using alsa ("Control the exact moment of output"), but it appears this
> list is more
> about development of alsa itself.
>
> Is there another place where discussions about using alsa are more
> appropriate,
> and/or a place where documentation can be found that goes a bit further
> than a
> plain list of function names and parameter lists?
> I.e. a more general description about how one structures an application
> that uses
> alsa, and how timing fits in that picture.
>


Hi Rob,

This list is more focused on driver development. At the moment the
official documentation is sparse. There is a lot of example code available
in open source applications.

What exactly are you looking to achieve?

FYI, most professional audio application developers tend to work with JACK
rather than ALSA directly.  There is also Pulse-Audio and gstreamer.

You might find that you have more luck discussing application development
on the LAD list.

There is also the JACK-devel list.


--
Patrick Shirkey
Boost Hardware Ltd
