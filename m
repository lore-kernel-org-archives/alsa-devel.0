From: Daniel Mack <daniel@zonque.org>
Subject: Re: caiaq driver: audio 4 dj and jackd
Date: Tue, 10 Dec 2013 11:39:10 +0100
Message-ID: <52A6EF4E.4030205@zonque.org>
References: <529BF843.6000608@gmail.com>
 <20131202095948.GA2886@tamtam.fritz.box> <529CA3FC.1040301@gmail.com>
 <529CAE8D.6020003@zonque.org> <529FFD07.5040408@gmail.com>
 <52A67BFC.6030707@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail.zonque.de (svenfoo.org [82.94.215.22])
 by alsa0.perex.cz (Postfix) with ESMTP id 9417D26518A
 for <alsa-devel@alsa-project.org>; Tue, 10 Dec 2013 11:39:11 +0100 (CET)
In-Reply-To: <52A67BFC.6030707@gmail.com>
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
Cc: Alsa-devel <alsa-devel@alsa-project.org>, Antonio Ospite <ao2@amarulasolutions.com>
List-Id: alsa-devel@alsa-project.org

Hi Gabe,

On 12/10/2013 03:27 AM, Gabriel M. Beddingfield wrote:
> On 12/04/2013 08:11 PM, Gabriel M. Beddingfield wrote:
>> On 12/02/2013 08:00 AM, Daniel Mack wrote:
>> Suppose a 2nd PCM device is added that would allow 1-4 channel
>> playback/capture (call it "Multichannel Audio" or something).  This pcm1
>> would be mutually exclusive with pcm0 (I.e. while one is open you can't
>> use the other).
>>
>> Existing applications using hw:n,0,0 and hw:n,0,1 see the exact same
>> interface/behavior.  The only failure mode is if the multichannel PCM is
>> in use.
>>
>> Applications using multichannel work-flows would use hw:n,1.
>>
>> While it's not a "just works" solution -- directing users to hw:n,1 is a
>> whole lot better than teaching them how to set up a multi plugin.
> 
> I'm considering buying one of these Audio 4 DJ devices to make this 
> change.  Would you be willing to take a change like this?

Well, yes. The longer I think about it, the more I believe it would be
worth a try how such a modified driver behaves.

I might do it myself, but it'll take a while until I can start working
on it. If you are willing to help, I'd happily test a patch :)


Daniel
