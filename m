From: Thomas Charbonnel <thomas@undata.org>
Subject: Re: HDSP 9632 driver and expansion cards
Date: Wed, 21 Jan 2004 16:08:34 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <400E95F2.2070103@undata.org>
References: <200401211316.i0LDGmqh009083@dhin.linuxaudiosystems.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 8bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <200401211316.i0LDGmqh009083@dhin.linuxaudiosystems.com>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Paul Davis a écrit :
>>Anyone using the latest RME HDSP 9632 driver in ALSA, while also using
>>the expansion cards? I mean, the newer AI4S-192 and/or AO4S-192 which
>>are required to get the 192kHz sampling on all analogs.
>>
>>Do the latest expansion cards (192kHz) work with the latest ALSA driver?
> 
> 
> i doubt it. RME have not given us any information about this new
> hardware. i suggest that you write to them and ask that they give me
> and/or thomas charbonnel the required information.
> 
> 
>>In general, are the ALSA drivers ready to support any kind of expansion
>>cards on the HDSP 9632 / HDSP 9652?
> 
> 
> they are "ready to support" in the sense that it probably isn't that
> much work, but they do not currently do so.
> 
> --p
> 


To clarify the situation : I already asked for and got this information 
while working on the H9632 driver. The code to support those expansion 
boards is already in the driver, and also in hdspmixer and hdspconf, the 
only thing is that this is untested. I also added traditional (old) 
expansion boards support for H96xx cards (you have to activate the board 
using hdspconf or amixer).

Thomas



-------------------------------------------------------
The SF.Net email is sponsored by EclipseCon 2004
Premiere Conference on Open Tools Development and Integration
See the breadth of Eclipse activity. February 3-5 in Anaheim, CA.
http://www.eclipsecon.org/osdn
