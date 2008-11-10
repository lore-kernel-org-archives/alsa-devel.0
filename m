From: "Nick Kossifidis" <mickflemm-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Subject: Re: Bugs on aspire one A150
Date: Tue, 11 Nov 2008 00:12:14 +0200
Message-ID: <40f31dec0811101412n1a4faf86sf4b1f37bb41caef9@mail.gmail.com>
References: <491506DB.1070000@gmail.com>
	<b6c5339f0811100851t1fd9a180pfe24312081885467@mail.gmail.com>
	<4918A8C5.3050607@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <ath5k-devel-bounces-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org>
In-Reply-To: <4918A8C5.3050607-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Content-Disposition: inline
List-Unsubscribe: <https://lists.ath5k.org/mailman/listinfo/ath5k-devel>,
	<mailto:ath5k-devel-request-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org?subject=unsubscribe>
List-Archive: <http://lists.ath5k.org/pipermail/ath5k-devel>
List-Post: <mailto:ath5k-devel-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org>
List-Help: <mailto:ath5k-devel-request-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org?subject=help>
List-Subscribe: <https://lists.ath5k.org/mailman/listinfo/ath5k-devel>,
	<mailto:ath5k-devel-request-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org?subject=subscribe>
Sender: ath5k-devel-bounces-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org
Errors-To: ath5k-devel-bounces-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org
To: Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>
Cc: linux-pm-cunTk1MwBs9QetFLy7KEm3xJsTq8ys+cHZ5vskTnxNA@public.gmane.org, ath5k-devel-xDcbHBWguxEUs3QNXV6qNA@public.gmane.org, linux-kernel-u79uwXL29TY76Z2rM5mHXA@public.gmane.org, alsa-devel-K7yf7f+aM1XWsZ/bQMPhNw@public.gmane.org
List-Id: alsa-devel@alsa-project.org

2008/11/10 Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org>:
> Bob Copeland wrote:
>> On Fri, Nov 7, 2008 at 10:26 PM, Maxim Levitsky <maximlevitsky-Re5JQEeQqe8AvxtiuMwx3w@public.gmane.org> wrote:
>>> ** 2 - wireless: not to mention the fact that ath5k wasn't installed by
>>> default in ubuntu...
>>> wireless more or less works, but kernel log is full of backtraces.
>>
>> As you've seen, these should at least be gone now...
>>
>>> Was able to connect to my WPA2 access point.
>>> Sometimes wireless fails completely, especially after suspend to ram.
>>
>> Did you get noise calibration failures in dmesg at this point?  Felix posted
>> a patch recently that handles them better.
> Yep, but they seems to be gone in latest -git too.
> Wireless work fine now, it seems like my iwl3945.
>
>>
>>> Advanced features like monitor/injection work, but when I changed the card's
>>> mac address it stopped working.
>>> I also noticed that if I then start airodump, then wireless works with new
>>> mac.
> Why it doesn't accept new mac?, can this be fixed?
>
>
>>
>>> ** 4 - wireless led doesn't work.
>>> ath5k devs, can you fix this?
>>
>> Currently all the LED code we have in there is for setting a particular gpio
>> for particular laptops (and they differ between models).  We only have quirks
>> for IBM and HP, none for Acer.  Also, the legacy-hal seems to have a different
>> strategy for 2425 chips.  I can try to hack up some code for you to test.
>>
>
> I have seen on the web that madwifi did support the led with some gpio settings
>
> sysctl -w dev.wifi0.ledpin=3
> sysctl -w dev.wifi0.softled=1
>
> from https://help.ubuntu.com/community/AspireOne
>
> Best regards,
>        Maxim Levitsky

i think that some led settings are stored on EEPROM, let me check it out...


-- 
GPG ID: 0xD21DB2DB
As you read this post global entropy rises. Have Fun ;-)
Nick
