From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: USB-Audio.conf routing and dmix
Date: Wed, 13 May 2015 11:24:32 +0200
Message-ID: <55531850.1020208@ladisch.de>
References: <20150509002017.GB18945@freedom> <20150511195734.GA12233@freedom>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dehamd003.servertools24.de (dehamd003.servertools24.de
 [31.47.254.18]) by alsa0.perex.cz (Postfix) with ESMTP id EEEC2265CA8
 for <alsa-devel@alsa-project.org>; Wed, 13 May 2015 11:24:35 +0200 (CEST)
In-Reply-To: <20150511195734.GA12233@freedom>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: sylvain.bertrand@gmail.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

sylvain.bertrand@gmail.com wrote:
> did I post on the right mailing list for alsa-lib default configuration improvment?

Yes.

>> I noticed that the proper channels routing was missing from the default generic
>> USB pcm

The "default" device is supposed to have two channels.

>> I guess the proper way would be to detect the hw card number of
>> channels and select a route plugin configuration with the correct
>> count of channels (maybe their is a function to get that info?).

The number of channels can depend on other factors.

>> I linked the surround51 and surround71 pcms with the 'disable-able' dmix
>> section from the default pcm.

These devices are not supposed to use plug or dmix.


Regards,
Clemens
