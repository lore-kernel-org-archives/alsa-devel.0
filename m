From: Guilherme Longo <grlongo.ireland@gmail.com>
Subject: Re: [Jack-Devel] Says: server is not connected,
 even though it has been!
Date: Fri, 10 Jul 2009 11:18:28 -0300
Message-ID: <4A574DB4.7010906@gmail.com>
References: <4A5715FA.2010605@gmail.com> <4A5722F1.6060707@boosthardware.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mail-px0-f192.google.com (mail-px0-f192.google.com
	[209.85.216.192])
	by alsa0.perex.cz (Postfix) with ESMTP id 9D6DA246B8
	for <alsa-devel@alsa-project.org>;
	Fri, 10 Jul 2009 16:18:35 +0200 (CEST)
Received: by pxi30 with SMTP id 30so607302pxi.16
	for <alsa-devel@alsa-project.org>; Fri, 10 Jul 2009 07:18:34 -0700 (PDT)
In-Reply-To: <4A5722F1.6060707@boosthardware.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Patrick Shirkey <pshirkey@boosthardware.com>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Yes Patrick.... same user for both

Really strange, isn't it!

Patrick Shirkey wrote:
>
> On 07/10/2009 05:20 PM, Guilherme Longo wrote:
>> Hi all!
>>
>> I couldn't find where this problem comes from.
>
> Hi,
>
> Sorry, to ask the obvious but, are you running as the same user for 
> the server and the simple_client?
>
>
> Patrick Shirkey
> Boost Hardware Ltd
>
>
>
>> I am connecting jack with the command:
>>
>> jackd -d alsa  -d default
>>
>> and appears right below:
>>
>> bash-3.1# jackd -d alsa -d default
>> jackdmp 1.9.2
>> Copyright 2001-2005 Paul Davis and others.
>> Copyright 2004-2008 Grame.
>> jackdmp comes with ABSOLUTELY NO WARRANTY
>> This is free software, and you are welcome to redistribute it
>> under certain conditions; see the file COPYING for details
>> JACK server starting in non-realtime mode
>> creating alsa driver ... 
>> default|default|1024|2|48000|0|0|nomon|swmeter|-|32bit
>> Using ALSA driver EMU10K1 running on SB Live [Unknown] (rev.10, 
>> serial:0x80671102) at 0xd000, irq 18
>> configuring for 48000Hz, period = 1024 frames (21.3 ms), buffer = 2 
>> periods
>> ALSA: final selected sample format for capture: 32bit float 
>> little-endian
>> You appear to be using the ALSA software "plug" layer, probably
>> a result of using the "default" ALSA device. This is less
>> efficient than it could be. Consider using a hardware device
>> instead rather than using the plug layer. Usually the name of the
>> hardware device that corresponds to the first soun
>> ALSA: use 2 periods for capture
>> ALSA: final selected sample format for playback: 32bit float 
>> little-endian
>> You appear to be using the ALSA software "plug" layer, probably
>> a result of using the "default" ALSA device. This is less
>> efficient than it could be. Consider using a hardware device
>> instead rather than using the plug layer. Usually the name of the
>> hardware device that corresponds to the first soun
>> ALSA: use 2 periods for playback
>>
>>
>> In another terminal, I am running a simple_cliente, and when I run it 
>> with the code:
>>
>> quart$: simple_client audiofile
>> jack server not running?
>>
>> It is resulting of:
>>
>> if ((client = jack_client_open(argv[1], JackNoStartServer, NULL)) == 
>> 0) {
>>                  fprintf (stderr, "jack server not running?\n");
>>                  return 1;
>>          }
>>
>>
>> Plz, can I get som help here.
>> Tks.
>> _______________________________________________
>> Jack-Devel mailing list
>> Jack-Devel@lists.jackaudio.org
>> http://lists.jackaudio.org/listinfo.cgi/jack-devel-jackaudio.org
>
