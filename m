From: Joakim Tjernlund <Joakim.Tjernlund@infinera.com>
Subject: Re: Different audio sample rate between in and
 out(44100 Hz resp. 44100 Hz)
Date: Mon, 11 Sep 2017 06:55:37 +0000
Message-ID: <1505112936.31322.75.camel@infinera.com>
References: <1504632355.27247.43.camel@infinera.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from NAM03-BY2-obe.outbound.protection.outlook.com
 (mail-by2nam03on0089.outbound.protection.outlook.com [104.47.42.89])
 by alsa0.perex.cz (Postfix) with ESMTP id 0DEFB266C6D
 for <alsa-devel@alsa-project.org>; Mon, 11 Sep 2017 08:55:42 +0200 (CEST)
In-Reply-To: <1504632355.27247.43.camel@infinera.com>
Content-Language: en-US
Content-ID: <DE8AD5D9434C674EA268A69912676180@infinera.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On Tue, 2017-09-05 at 19:25 +0200, Joakim Tjernlund wrote:
> When starting a audio chat I often have problems with my microphon and recenly I
> found that the sample rate is different for in and out:
> # > cat /proc/asound/card1/stream0
> Logitech Inc Logitech Stereo H650e at usb-0000:00:1d.0-1.7, full speed : USB Audio
> 
> Playback:
>   Status: Running
>     Interface = 2
>     Altset = 1
>     Packet Size = 192
>     Momentary freq = 48000 Hz (0x30.0000)
>   Interface 2
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 1 OUT (ADAPTIVE)
>     Rates: 8000, 16000, 24000, 32000, 44100, 48000
> 
> Capture:
>   Status: Running
>     Interface = 1
>     Altset = 1
>     Packet Size = 200
>     Momentary freq = 44100 Hz (0x2c.199a)
>   Interface 1
>     Altset 1
>     Format: S16_LE
>     Channels: 2
>     Endpoint: 1 IN (ASYNC)
>     Rates: 8000, 16000, 24000, 32000, 44100, 48000
> 
> This seems odd to me. Adding some debug to kernel I see:
> [  129.858365] usb 1-2: 1:1: setting freq 44100 to ep 0x81
> [  129.860514] usb 1-2: 1:1: setting freq 44100 to ep 0x81
> [  131.884314] usb 1-2: 2:1: setting freq 44100 to ep 0x1
> [  131.886567] usb 1-2: 2:1: setting freq 44100 to ep 0x1
> [  131.898714] usb 1-2: 2:1: setting freq 48000 to ep 0x1
> [  131.900847] usb 1-2: 2:1: setting freq 48000 to ep 0x1
> 
> 
> Is this expected or should I try make both the same?
> 
>  Jocke

Ping?
