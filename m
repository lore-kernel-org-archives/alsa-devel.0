From: "OrazioPirataDelloSpazio (Lorenzo)" <ziducaixao@autistici.org>
Subject: Mic threshold trigger
Date: Wed, 05 Nov 2008 01:09:47 +0100
Message-ID: <4910E44B.60103@autistici.org>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp.uniroma2.it (smtp.uniroma2.it [160.80.6.22])
	by alsa0.perex.cz (Postfix) with ESMTP id DAEC024332
	for <alsa-devel@alsa-project.org>; Wed,  5 Nov 2008 01:09:52 +0100 (CET)
Received: from lists.uniroma2.it (lists.uniroma2.it [160.80.1.182])
	by smtp.uniroma2.it (8.13.6/8.13.6) with ESMTP id mA50oj8K013869
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2008 01:50:47 +0100
Received: from apple-juice.local (adsl-ull-165-101.50-151.net24.it
	[151.50.101.165]) (authenticated bits=0)
	by lists.uniroma2.it (8.13.1/8.13.1) with ESMTP id mA509mGn003865
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 5 Nov 2008 01:09:49 +0100
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Hello,
I would like to create a simple trigger from a microphone input, using alsa.
For example I would like that every time I short-circuit a jack inserted 
in the "mic hole", my program say "Hello World".
I would like that this application will be lightweight (I don't need 
audio quality, just a trigger!) and that cohexists with other apps that 
should keep using the output of the same sound card.

My idea was to simply code a raw "snd_pcm_readi" call and after compare 
each sample of the captured block with a threshold. For instance, if the 
90% of sample are above the given threshold, the trigger must act.

Of course it doesn't work :-)

I plug a simple jack in the mic, and open or short-circuit the poles. In 
the captured block, I can find only samples between 0xFFE0 and 0xFFFF 
(and some sporadic 0x0000).

Any hits? Thanks

Lorenzo
