From: James Courtier-Dutton <James@superbug.demon.co.uk>
Subject: Re: A7N8X Deluxe - Alsa Support???
Date: Sun, 19 Oct 2003 22:58:06 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3F9308EE.5060703@superbug.demon.co.uk>
References: <1066587533.2642.8.camel@Wizard.knechthome.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1066587533.2642.8.camel@Wizard.knechthome.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Knecht <markknecht@comcast.net>
Cc: Alsa-Devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Mark Knecht wrote:
> Hi,
>    Is there any Alsa support for the sound chips used on the Asus A7N8X
> Deluxe MB? I Do not see anything on the sound card matrix page.
> 
>    If there is support, what works and what doesn't? IS it stable? VERY
> STABLE?I'm building this machine for my dad and don't want to mess with
> it after I set it up.
> 
>>From the Asus page:
> 
> Audio RealtekR ALC650 6CH w/built in HP amplifier
> Integrated APU(Audio Processor Unit) SoundStorm?/ DolbyR Digital (AC-3)
> Encoder	
> 
> Cheers,
> Mark
> 
Send me the output of: -
lspci -n |grep "Class 0401"


And then we can tell you if alsa supports it or not yet.



-------------------------------------------------------
This SF.net email sponsored by: Enterprise Linux Forum Conference & Expo
The Event For Linux Datacenter Solutions & Strategies in The Enterprise 
Linux in the Boardroom; in the Front Office; & in the Server Room 
http://www.enterpriselinuxforum.com
