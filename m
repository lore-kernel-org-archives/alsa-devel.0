From: Henning Thielemann <alsa@henning-thielemann.de>
Subject: snd_seq_parse_address matching prefix
Date: Tue, 13 Mar 2012 23:46:52 +0100 (CET)
Message-ID: <alpine.DEB.2.00.1203132333121.5893@anubis.informatik.uni-halle.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mailgate5.urz.uni-halle.de (mailgate5.urz.uni-halle.de
	[141.48.3.10]) by alsa0.perex.cz (Postfix) with ESMTP id 0707E103A6E
	for <alsa-devel@alsa-project.org>; Tue, 13 Mar 2012 23:46:56 +0100 (CET)
Received: from mserv3.urz.uni-halle.de ([141.48.3.161])
	by mlucom18.urz.uni-halle.de with esmtps (TLSv1:RC4-MD5:128)
	(Exim 4.77) id 1S7aUZ-0006Wp-Kl for <alsa-devel@alsa-project.org>
	; Tue, 13 Mar 2012 23:46:55 +0100
Received: from hermes.informatik.uni-halle.de ([141.48.9.46])
	by mail.uni-halle.de
	(Sun Java(tm) System Messaging Server 6.3-15.01 (built Mar 21 2011;
	32bit)) with ESMTP id <0M0U00GW1HY58R60@mail.uni-halle.de> for
	alsa-devel@alsa-project.org; Tue, 13 Mar 2012 23:46:53 +0100 (CET)
Received: from anubis.informatik.uni-halle.de
	(anubis.informatik.uni-halle.de [141.48.165.107])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)	by hermes.informatik.uni-halle.de
	(Postfix)
	with ESMTPS id 425A64E321DE	for <alsa-devel@alsa-project.org>; Tue,
	13 Mar 2012 23:46:53 +0100 (CET)
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


snd_seq_parse_address(seq, addr, "foo") does not look for a client named 
"foo" but for a client with prefix "foo". I always found this to be a 
feature, not a bug, although it is not documented. Is this behavior 
intended? If yes, how to cope with the case where one client's name is the
prefix of another one? E.g. let the clients be

"foobar"
"foo"

(in this order)
then parsing "foo" will return the client address of "foobar", not that of 
"foo". Even more there is no prefix that will select "foo", but not 
"foobar".
  Sorting the clients with respect to increasing name lengths and then 
searching for matching prefixes in the sorted list would solve that 
problem.

Currently it's only a theoretical problem but if that behavior is intended 
it should at least be documented. Using snd_seq_query_next_client everyone 
can write his own parse_address. We should only know about the theoretical 
problem.
