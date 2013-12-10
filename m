From: "Gabriel M. Beddingfield" <gabrbedd@gmail.com>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Mon, 09 Dec 2013 18:27:08 -0800
Message-ID: <52A67BFC.6030707@gmail.com>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box> <529CA3FC.1040301@gmail.com>
 <529CAE8D.6020003@zonque.org> <529FFD07.5040408@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"; Format="flowed"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-pd0-f181.google.com (mail-pd0-f181.google.com
 [209.85.192.181])
 by alsa0.perex.cz (Postfix) with ESMTP id DBBD6264F1A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 03:27:19 +0100 (CET)
Received: by mail-pd0-f181.google.com with SMTP id p10so6346629pdj.12
 for <alsa-devel@alsa-project.org>; Mon, 09 Dec 2013 18:27:18 -0800 (PST)
In-Reply-To: <529FFD07.5040408@gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Daniel Mack <daniel@zonque.org>
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Hi Daniel,

On 12/04/2013 08:11 PM, Gabriel M. Beddingfield wrote:
> On 12/02/2013 08:00 AM, Daniel Mack wrote:
> Suppose a 2nd PCM device is added that would allow 1-4 channel
> playback/capture (call it "Multichannel Audio" or something).  This pcm1
> would be mutually exclusive with pcm0 (I.e. while one is open you can't
> use the other).
>
> Existing applications using hw:n,0,0 and hw:n,0,1 see the exact same
> interface/behavior.  The only failure mode is if the multichannel PCM is
> in use.
>
> Applications using multichannel work-flows would use hw:n,1.
>
> While it's not a "just works" solution -- directing users to hw:n,1 is a
> whole lot better than teaching them how to set up a multi plugin.

I'm considering buying one of these Audio 4 DJ devices to make this 
change.  Would you be willing to take a change like this?

Thanks,
Gabe
