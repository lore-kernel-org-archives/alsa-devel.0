From: "Rui Nuno Capela" <rncbc@rncbc.org>
Subject: Re: Re: [Alsa-user] alsa-driver-1.0.4rc1 missing  
     snd-usb-usx2y ?
Date: Thu, 1 Apr 2004 16:01:53 +0100 (WEST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <37214.195.245.190.94.1080831713.squirrel@www.rncbc.org>
References: <44618.195.245.190.94.1080560065.squirrel@www.rncbc.org>
    <45386.195.245.190.94.1080632967.squirrel@www.rncbc.org>
    <32795.192.168.1.5.1080679902.squirrel@www.rncbc.org>
    <200404011457.41884.annabellesgarden@yahoo.de>
Mime-Version: 1.0
Content-Type: text/plain;charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200404011457.41884.annabellesgarden@yahoo.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Karsten Wiese wrote:
>> >>> the snd-usb-usx2y module. AFAICT it's not being included by
>> >>> ./configure --with-cards option, nor it gets built when one sets
>> >>> --with-cards=all.
>> >>
>> >> It is fixed in CVS now. Thanks.
>>
>> Checked out today's alsa-driver-1.0.4rc2 where the missed snd-usb-usx2y
>> module gets built now.
>>
>> However, I couldn't get it to load, dmesg gives:
>>
>> snd_usb_usx2y: Unknown symbol snd_pcm_dma_flags
>>
>> All other alsa packages are up to 1.0.4rc1 here.
>>
> CVS today: OK here with 2.4 and 2.6.5-rc3. Have you tried a fresh
> checkout?

No I didn't, I was with the stock source tarballs. Haven't the time to
checkout from CVS, yet.

BTW, Karsten,

Haven't you check my latest messages that I recently sent to you about the
US-224 topic? Those that were being sent off the list. I'm still missing
your usbsnoop stuff.

Cheers.
-- 
rncbc aka Rui Nuno Capela
rncbc@rncbc.org


-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
