Return-Path: <alsa-devel-bounces@alsa-project.org>
Date: Thu, 9 May 2013 10:38:08 -0400 (EDT)
From: Alan Stern <stern@rowland.harvard.edu>
In-Reply-To: <20130509001613.GA4383@richardiv.omgwallhack.org>
Message-ID: <Pine.LNX.4.44L0.1305091037150.1796-100000@iolanthe.rowland.org>
MIME-Version: 1.0
Subject: Re: [alsa-devel] BUG: USB audio discontinuities with 'UHCI:
 implement new semantics for URB_ISO_ASAP'
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
Cc: tova-dev@tovacompany.com, linux-usb@vger.kernel.org, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@vger.kernel.org, stable@vger.kernel.org
List-ID: <alsa-devel@alsa-project.org>

On Wed, 8 May 2013, Joe Rayhawk wrote:

> For what it's worth, the following -stable patch
> 
> "ALSA: USB: adjust for changed 3.8 USB API"
> c75c5ab575af7db707689cdbb5a5c458e9a034bb
> 
> fixes the discontinuous playback on period sizes between 139 and 192,
> but the discontinuous playback on period sizes between 48 and 138 has
> been replaced by rather worse kernel blocking and kernel errors:
> 
> jrayhawk@richardiv:~$ sudo tail -F -n 0 /var/log/kern.log &
> [1] 4490
> jrayhawk@richardiv:~$ time perl -e 'print pack "H*", "00FF" x 2048' | aplay --period-size=192 -r 48000 -f S16_LE -c2 -D hw:0,0
> Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> 
> real	0m0.053s
> user	0m0.008s
> sys	0m0.000s
> jrayhawk@richardiv:~$ time perl -e 'print pack "H*", "00FF" x 2048' | aplay --period-size=48 -r 48000 -f S16_LE -c2 -D hw:0,0
> Playing raw data 'stdin' : Signed 16 bit Little Endian, Rate 48000 Hz, Stereo
> May  8 17:01:56 richardiv kernel: [ 1680.923474] cannot submit urb (err = -18)
> May  8 17:01:56 richardiv kernel: [ 1680.924472] cannot submit urb (err = -18)
> 
> real	0m10.023s
> user	0m0.008s
> sys	0m0.004s

I don't know if you want to investigate this in any detail.  If you do, 
please post a usbmon trace of a failed playback.

Alan Stern

--
To unsubscribe from this list: send the line "unsubscribe alsa-devel" in
the body of a message to majordomo@vger.kernel.org
More majordomo info at  http://vger.kernel.org/majordomo-info.html

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
