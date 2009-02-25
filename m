From: Clive Messer <clive@vacuumtube.org.uk>
Subject: Re: Timer instability
Date: Wed, 25 Feb 2009 15:11:44 +0000
Message-ID: <200902251511.44049.clive@vacuumtube.org.uk>
References: <20090219024611.GA7930@tango.0pointer.de>
	<200902251234.37222.clive@vacuumtube.org.uk>
	<s5hvdqyocyw.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="Boundary-00=_w+VpJ0qR0QSRisy"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from abbey4.objectsoft-systems.ltd.uk
	(abbey4.objectsoft-systems.ltd.uk [87.194.123.10])
	by alsa0.perex.cz (Postfix) with ESMTP id 3EBFF103821
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 16:11:45 +0100 (CET)
Received: from c7p6t.objectsoft-systems.ltd.uk
	(abbey1.objectsoft-systems.ltd.uk [87.194.123.7])
	(authenticated bits=0)
	by abbey4.objectsoft-systems.ltd.uk (8.14.2/8.14.2) with ESMTP id
	n1PFBiAJ022593
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-SHA bits=256 verify=NO)
	for <alsa-devel@alsa-project.org>; Wed, 25 Feb 2009 15:11:44 GMT
In-Reply-To: <s5hvdqyocyw.wl%tiwai@suse.de>
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

--Boundary-00=_w+VpJ0qR0QSRisy
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

On Wednesday 25 Feb 2009 13:36:23 Takashi Iwai wrote:

> Could you check whether this error happens with sync_ptr_ioctl flag
> in PCM config?  For example, define the below in ~/.asoundrc,
>
> 	pcm.mytest {
> 		type hw
> 		card 0
> 		sync_ptr_ioctl true
> 	}
>
> Then run with PCM "mytest".

./alsa-time-test mytest > pcm_mytest.log

head & tail 50 lines - attached.

Regards

Clive
-- 
Clive Messer <clive@vacuumtube.org.uk>


--Boundary-00=_w+VpJ0qR0QSRisy
Content-Type: text/x-log;
  charset="UTF-8";
  name="mytest.log"
Content-Transfer-Encoding: 7bit
Content-Disposition: attachment;
	filename="mytest.log"

20988	20986	0	4416	0	4	1	2
21002	21002	22	4415	0	4	1	2
21006	21006	45	4414	0	4	1	2
21010	21009	68	4413	0	4	1	2
21014	21013	90	4412	0	4	1	2
21024	21022	113	4411	0	4	1	2
21028	21027	136	4410	0	4	1	2
21033	21032	158	4409	0	4	1	2
21036	21035	181	4408	0	4	1	2
21040	21040	204	4407	0	4	1	2
21044	21043	226	4406	0	4	1	2
21047	21046	249	4405	0	4	1	2
21050	21049	272	4404	0	4	1	2
21053	21053	294	4403	0	4	1	2
21061	21061	317	4402	0	4	1	2
21065	21064	340	4401	0	4	1	2
21068	21067	362	4400	0	4	1	2
21071	21070	385	4399	0	4	1	2
21074	21074	408	4398	0	4	1	2
21078	21077	430	4397	0	4	1	2
21081	21080	453	4396	0	4	1	2
21084	21083	476	4395	0	4	1	2
21087	21087	498	4394	0	4	1	2
21091	21090	521	4393	0	4	1	2
21094	21093	544	4392	0	4	1	2
21097	21096	566	4391	0	4	1	2
21100	21100	589	4390	0	4	1	2
21104	21103	612	4389	0	4	1	2
21107	21106	634	4388	0	4	1	2
21110	21109	657	4387	0	4	1	2
21113	21113	680	4386	0	4	1	2
21116	21116	702	4385	0	4	1	2
21120	21119	725	4384	0	4	1	2
21123	21122	748	4383	0	4	1	2
21126	21125	770	4382	0	4	1	2
21129	21129	793	4381	0	4	1	2
21133	21132	816	4380	0	4	1	2
21136	21135	839	4379	0	4	1	2
21139	21138	861	4378	0	4	1	2
21142	21142	884	4377	0	4	1	2
21145	21145	907	4376	0	4	1	2
21149	21148	929	4375	0	4	1	2
21152	21151	952	4374	0	4	1	2
21155	21154	975	4373	0	4	1	2
21158	21158	997	4372	0	4	1	2
21162	21161	1020	4371	0	4	1	2
21165	21164	1043	4370	0	4	1	2
21168	21167	1065	4369	0	4	1	2
21171	21171	1088	4368	0	4	1	2
21175	21174	1111	4367	0	4	1	2
36046	36045	99115	45	0	0	1	2
36049	36049	99138	44	0	0	1	2
36052	36052	99160	43	0	0	1	2
36060	36059	99183	42	0	0	1	2
36063	36062	99206	41	0	0	1	2
36066	36065	99229	40	0	0	1	2
36069	36069	99251	39	0	0	1	2
36072	36072	99274	38	0	0	1	2
36076	36075	99297	37	0	0	1	2
36079	36078	99319	36	0	0	1	2
36082	36081	99342	35	0	0	1	2
36085	36085	99365	34	0	0	1	2
36088	36088	99387	33	0	0	1	2
36092	36091	99410	32	0	0	1	2
36095	36094	99433	31	0	0	1	2
36098	36098	99455	30	0	0	1	2
36101	36101	99478	29	0	0	1	2
36105	36104	99501	28	0	0	1	2
36108	36107	99523	27	0	0	1	2
36111	36110	99546	26	0	0	1	2
36114	36114	99569	25	0	0	1	2
36117	36117	99591	24	0	0	1	2
36121	36120	99614	23	0	0	1	2
36124	36123	99637	22	0	0	1	2
36127	36126	99659	21	0	0	1	2
36130	36130	99682	20	0	0	1	2
36133	36133	99705	19	0	0	1	2
36137	36136	99727	18	0	0	1	2
36140	36139	99750	17	0	0	1	2
36143	36142	99773	16	0	0	1	2
36146	36146	99795	15	0	0	1	2
36150	36149	99818	14	0	0	1	2
36153	36152	99841	13	0	0	1	2
36156	36155	99863	12	0	0	1	2
36159	36159	99886	11	0	0	1	2
36162	36162	99909	10	0	0	1	2
36166	36165	99931	9	0	0	1	2
36169	36168	99954	8	0	0	1	2
36172	36171	99977	7	0	0	1	2
36175	36175	100000	6	0	0	1	2
36179	36178	100022	5	0	0	1	2
36188	36188	100045	4	0	0	1	2
36192	36191	100068	3	0	0	1	2
36195	36194	100090	2	0	0	1	2
36198	36198	100113	1	0	0	1	2
36207	36206	63854	2816	1600	0	1	3
36212	36211	63854	2815	1601	4	1	3
36216	36216	63854	2814	1602	4	1	3
36221	36220	63854	2813	1603	4	1	3
36225	36225	101224	4460	-44	4	1	3

--Boundary-00=_w+VpJ0qR0QSRisy
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--Boundary-00=_w+VpJ0qR0QSRisy--
