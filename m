From: Rene Herman <rene.herman@keyaccess.nl>
Subject: Re: [Alsa-user] Pc Speaker
Date: Tue, 13 May 2008 13:14:38 +0200
Message-ID: <4829781E.6040909@keyaccess.nl>
References: <20080513110322.030a5386.zoup@zoup.org>	<48296CFF.5000207@keyaccess.nl>
	<20080513151425.448369e8.zoup@zoup.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpq1.tilbu1.nb.home.nl (smtpq1.tilbu1.nb.home.nl
	[213.51.146.200])
	by alsa0.perex.cz (Postfix) with ESMTP id 2466E24ACF
	for <alsa-devel@alsa-project.org>;
	Tue, 13 May 2008 13:13:10 +0200 (CEST)
In-Reply-To: <20080513151425.448369e8.zoup@zoup.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Armin ranjbar <zoup@zoup.org>
Cc: alsa-user@lists.sourceforge.net, ALSA devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

On 13-05-08 12:44, Armin ranjbar wrote:

>> Device Drivers ->
>>   Input device support ->
>>     Miscelaneous devices
>>
>> With current mainline, it's:
>>
>> General setup ->
>>   Configure standard kernel features (for small systems)
>>      Enable PC-Speaker support
> 
> Thank you very much for your reply , 
> 
> but i have to say that i have this options activated , still no pc
> speaker .

Rechecked. Yes, you need this option, you need the ALSA one disabled (not
modular, disabled) and then the PC speaker driver option appears in its
input menu where you want to enable it. Paths as given in last reply.

Yes, that would seem to be amazingly clumsily done. Perhaps there was a
reason (adding alsa-devel).

Rene.
