From: Eric Allamanche <alm@iis.fhg.de>
Subject: Re: Getting actual sample rate
Date: Tue, 10 Jun 2003 19:38:26 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3EE61792.2070702@iis.fhg.de>
References: <3EE5FF42.5080107@iis.fhg.de> <E19Plpg-0005Nv-00@sc8-sf-list1.sourceforge.net> <20030610171210.GA501@tuba.home>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20030610171210.GA501@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>, Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Thanks for feedback,

Martin Langer wrote:
> On Tue, Jun 10, 2003 at 12:24:21PM -0400, Paul Davis wrote:
> 
>>>I'm using a digital Hammerfall audio card and was wondering how to 
>>
>>which hammerfall? digi9652 or hdsp9652?

I think it's an older digi9652, I have to open the PC to check it out

>>the ALSA hardware parameter model doesn't include the notion of an
>>"external rate". 

Is this is a design flaw? How to tell the input frequency? Need some 
additionnal hardware?

>>there is no way to differentiate between an ADAT signal at 32/44.1/48
>>kHz and a "bit/channel stream format" at 64/88.2/96 kHz. so we can't
>>tell you that. however, on the hdsp series, the "External Rate"
>>control (read only) can be used to check the rate. i don't know
>>off hand whether it can be used for notifications via blocking on
>>read/poll for the control.
>>
> 
> 
> Up to now, I thought ADAT was only defined for 44.1 and 48 kHz, but maybe
> I'm wrong in this point. Ok, I believe that the hw doesn't use a restriction in
> that point. But are there really any devices that can handle all those rates.

I checked it again, ADAT is only defined for 44.1/48 kHz. I mixed it up 
with the Hammerfall specifications in the manual. The supported 
frequencies ranges from 32 to 96kHz (SPDIF mode?)

Eric



-------------------------------------------------------
This SF.net email is sponsored by:  Etnus, makers of TotalView, The best
thread debugger on the planet. Designed with thread debugging features
you've never dreamed of, try TotalView 6 free at www.etnus.com.
