From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: Boundary calculation
Date: Tue, 17 Jul 2018 17:33:43 +0200
Message-ID: <f0033a69-2d75-5fcf-9f12-56a120d470f9@ladisch.de>
References: <20180717131341.GA13614@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from webclient5.webclient5.de (webclient5.webclient5.de
 [136.243.32.184])
 by alsa0.perex.cz (Postfix) with ESMTP id 0A7D3267776
 for <alsa-devel@alsa-project.org>; Tue, 17 Jul 2018 17:34:08 +0200 (CEST)
In-Reply-To: <20180717131341.GA13614@localhost.localdomain>
Content-Language: en-US
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
Cc: Ricardo Biehl Pasquali <pasqualirb@gmail.com>
List-Id: alsa-devel@alsa-project.org

Ricardo Biehl Pasquali wrote:
> Clemens Ladisch wrote:
>> To ensure that the factor is a power of two.
>
> Ok, but why LONG_MAX - buffer_size?

To ensure that adding the position in the buffer to the current pointer
will not overflow.


Regards,
Clemens
