From: Fausto Carvalho Marques SIlva <fausto@tse.gov.br>
Subject: Alsa lib configure asoundlib.h
Date: Thu, 05 Jul 2007 12:15:06 -0300
Message-ID: <468D0AFA.20208@tse.gov.br>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from dexter.tse.gov.br (dexter.tse.gov.br [200.252.157.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 5C01E103859
	for <alsa-devel@alsa-project.org>;
	Thu,  5 Jul 2007 20:01:29 +0200 (CEST)
Received: from dexter.tse.gov.br (localhost.tse.gov.br [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id C1408FCF57
	for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2007 15:01:26 -0300 (BRT)
Received: from webmail.tse.gov.br (webmail.tse.gov.br [10.28.1.25])
	by dexter.tse.gov.br (Postfix) with ESMTP id BEC55FC33F
	for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2007 15:01:26 -0300 (BRT)
Received: from webmail.tse.gov.br (localhost.localdomain [127.0.0.1])
	by nod32.tse.gov.br (Postfix) with ESMTP id A8EC714C0D6
	for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2007 15:01:26 -0300 (BRT)
Received: from [10.28.219.33] (unknown [10.28.219.33])
	by webmail.tse.gov.br (Postfix) with ESMTP id A662314C0D5
	for <alsa-devel@alsa-project.org>; Thu,  5 Jul 2007 15:01:26 -0300 (BRT)
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

In salsa library(this library really saved my life, from am alsa-lib of 
600K to 45K!!!), developed by Takashi Iwai, the creation of  asoundlib.h 
is dynamic and based on the configure options ( --disable-mixer will 
remove mixer.h from asoundlib.h).
Can alsa-lib do the same??I think it is a good "cleanup" way of doing 
client header files.

Example from configure.ac from salsa-0.0.6:

"
echo "Creating asoundlib.h..."
cp "$srcdir"/src/asoundlib-head.h src/asoundlib.h
test "$mixer" = "yes" && echo "#include \"mixer.h\"" >> src/asoundlib.h
test "$rawmidi" = "yes" && echo "#include \"rawmidi.h\"" >> src/asoundlib.h
test "$hwdep" = "yes" && echo "#include \"hwdep.h\"" >> src/asoundlib.h
test "$timer" = "yes" && echo "#include \"timer.h\"" >> src/asoundlib.h
test "$sndconf" = "yes" && echo "#include \"conf.h\"" >> src/asoundlib.h
test "$sndseq" = "yes" && echo "#include \"seq_event.h\"" >> src/asoundlib.h
test "$sndseq" = "yes" && echo "#include \"seq.h\"" >> src/asoundlib.h
test "$sndseq" = "yes" && echo "#include \"seqmid.h\"" >> src/asoundlib.h
cat "$srcdir"/src/asoundlib-tail.h >> src/asoundlib.h
"

Fausto Carvalho Marques Silva
