From: Patrick Shirkey <pshirkey@boosthardware.com>
Subject: Re: Just a quick question...
Date: Tue, 13 Aug 2002 17:44:26 +0900
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <3D58C6EA.3030107@boosthardware.com>
References: <006c01c2429a$45e35b80$3c01a8c0@apprentice>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from www7.networkshosting.com ([66.96.128.106])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with SMTP id KAA18551
	for <alsa-devel@alsa-project.org>; Tue, 13 Aug 2002 10:40:20 +0200
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Jim <jbuckeyne@greater.net>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Jim wrote:
> I beleive that many modern cards have multiple hardware channels (err 
> not channels' that's like stereo... uhmm streams?) ?

You are correct.

>  I've been browsing 
> through the documentation, examples, faq's etc, and have found no 
> refernence to such things... So was wondering, does ALSA support 
> multiple opens to get multiple hardware (...) to allow the hardware 
> itself to mix?  Is this even a thing?  and if not - then what's it mean 
> when a sound card has 256 channels?  (64 3D) ...
>  

It's called hardware mixing and there is not much info availabel about 
it. There are a few cards/devices with ALSA drivers theat have support 
for hardware mixing. There are a few that have the capability but no 
support because the manufacturers  refuse to probvide the necessary 
specifications.

> And if it IS supported - any chance that on the driver page a field 
> could be added that's 'simultaneous opens?'
>  

Maybe not a field but a note. Lets call it [G] :)

> Jim
>  
> Maybe I'm asking something that's meaning something other than what I do 
> mean :)



-- 
Patrick Shirkey - Boost Hardware Ltd.
For the discerning hardware connoisseur
Http://www.boosthardware.com
Http://www.boosthardware.com/LAU/guide/
========================================



-------------------------------------------------------
This sf.net email is sponsored by: Dice - The leading online job board
for high-tech professionals. Search and apply for tech jobs today!
http://seeker.dice.com/seeker.epl?rel_code=31
